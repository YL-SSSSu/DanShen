//
//  SoftwareUpdater.swift
//  boringNotch
//
//  Created by Richard Kunkli on 09/08/2024.
//

import AppKit
import SwiftUI

struct CheckForUpdatesView: View {
    var body: some View {
        Button("Check for Updates...") {
            if let url = URL(string: "https://github.com/YL-SSSSu/DanShen/releases") {
                NSWorkspace.shared.open(url)
            }
        }
    }
}

struct UpdaterSettingsView: View {
    var body: some View {
        Section {
            Text("Automatic updates are disabled in this preview build.")
                .foregroundStyle(.secondary)
            CheckForUpdatesView()
        } header: {
            HStack {
                Text("Software updates")
            }
        }
    }
}
