//
//  BoringNotchWindow.swift
//  boringNotch
//
//  Created by Harsh Vardhan  Goswami  on 06/08/24.
//

import Cocoa
import Combine
import Defaults

@MainActor
final class AppWindowPresentationCoordinator {
    static let shared = AppWindowPresentationCoordinator()
    static let defaultNotchLevel = NSWindow.Level(
        rawValue: NSWindow.Level.mainMenu.rawValue + 3
    )

    private let presentedWindows = NSHashTable<NSWindow>.weakObjects()
    private let yieldedNotchWindows = NSHashTable<NSWindow>.weakObjects()
    private var cancellables = Set<AnyCancellable>()

    private init() {
        Defaults.publisher(.auxiliaryWindowsAlwaysOnTop)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.applyPresentationPolicy()
            }
            .store(in: &cancellables)
    }

    var hasPresentedWindows: Bool {
        presentedWindows.allObjects.contains {
            !$0.isMiniaturized
        }
    }

    func present(_ window: NSWindow) {
        if !presentedWindows.allObjects.contains(where: { $0 === window }) {
            presentedWindows.add(window)
        }
        configureAuxiliaryWindow(window)
        ScreenMediaBarController.shared.setSuppressedByAuxiliaryWindow(true)
        setNotchWindowsYielding(true)
    }

    func dismiss(_ window: NSWindow) {
        presentedWindows.remove(window)
        applyPresentationPolicy()
    }

    func refresh() {
        applyPresentationPolicy()
    }

    func relinquishApplicationFocusIfPossible() {
        let isAssistantVisible = (NSApp.delegate as? AppDelegate)?.hasOpenAssistantNotch == true
        guard !hasPresentedWindows, !isAssistantVisible else { return }
        NSApp.setActivationPolicy(.accessory)
        NSApp.deactivate()
    }

    private func applyPresentationPolicy() {
        for window in presentedWindows.allObjects {
            configureAuxiliaryWindow(window)
        }

        let hasActiveWindow = presentedWindows.allObjects.contains {
            !$0.isMiniaturized
        }
        ScreenMediaBarController.shared.setSuppressedByAuxiliaryWindow(hasActiveWindow)
        setNotchWindowsYielding(hasActiveWindow)
    }

    private func configureAuxiliaryWindow(_ window: NSWindow) {
        let staysOnTop = Defaults[.auxiliaryWindowsAlwaysOnTop]
        window.level = staysOnTop ? .floating : .normal
        window.collectionBehavior = [
            .managed,
            .participatesInCycle,
            .fullScreenAuxiliary,
            .moveToActiveSpace,
        ]
        if let panel = window as? NSPanel {
            panel.isFloatingPanel = staysOnTop
        }
    }

    private func setNotchWindowsYielding(_ shouldYield: Bool) {
        if shouldYield {
            for window in NSApp.windows where isNotchWindow(window) {
                window.level = .normal
                if window.isVisible {
                    yieldedNotchWindows.add(window)
                    window.orderOut(nil)
                }
            }
            return
        }

        for window in NSApp.windows where isNotchWindow(window) {
            window.level = Self.defaultNotchLevel
        }

        for window in yieldedNotchWindows.allObjects {
            window.level = Self.defaultNotchLevel
            window.orderFrontRegardless()
        }
        yieldedNotchWindows.removeAllObjects()
    }

    private func isNotchWindow(_ window: NSWindow) -> Bool {
        window is BoringNotchWindow || window is BoringNotchSkyLightWindow
    }
}

class BoringNotchWindow: NSPanel {
    override init(
        contentRect: NSRect,
        styleMask: NSWindow.StyleMask,
        backing: NSWindow.BackingStoreType,
        defer flag: Bool
    ) {
        super.init(
            contentRect: contentRect,
            styleMask: styleMask,
            backing: backing,
            defer: flag
        )
        
        isFloatingPanel = true
        isOpaque = false
        titleVisibility = .hidden
        titlebarAppearsTransparent = true
        backgroundColor = .clear
        isMovable = false
        becomesKeyOnlyIfNeeded = true
        hidesOnDeactivate = false
        
        collectionBehavior = [
            .fullScreenAuxiliary,
            .stationary,
            .canJoinAllSpaces,
            .ignoresCycle,
        ]
        
        isReleasedWhenClosed = false
        level = AppWindowPresentationCoordinator.defaultNotchLevel
        hasShadow = false
    }
    
    override var canBecomeKey: Bool {
        true
    }
    
    override var canBecomeMain: Bool {
        true
    }
}
