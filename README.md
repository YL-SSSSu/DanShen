# DanShen

[![macOS 14+](https://img.shields.io/badge/macOS-14%2B-black?logo=apple)](https://github.com/YL-SSSSu/DanShen/releases/latest)
[![Universal](https://img.shields.io/badge/Apple%20Silicon%20%2B%20Intel-universal-blue)](https://github.com/YL-SSSSu/DanShen/releases/latest)
[![License: GPL-3.0](https://img.shields.io/badge/license-GPL--3.0-green)](LICENSE)

**DanShen** (蛋神) is a macOS notch productivity assistant built on top of
[Boring Notch](https://github.com/TheBoredTeam/boring.notch). It keeps media,
weather, calendar, focus tools, connected-device battery status, and an optional
local-first AI agent in one compact desktop surface.

[简体中文](README.zh-CN.md)

## Download

Download the latest universal build from
[GitHub Releases](https://github.com/YL-SSSSu/DanShen/releases/latest).

Requirements:

- macOS 14 Sonoma or later
- Apple Silicon or Intel Mac

The preview build is not notarized. If macOS blocks the first launch, open
**System Settings > Privacy & Security** and choose **Open Anyway**. Do not run
DanShen and Boring Notch at the same time because they currently share parts of
the upstream application identity.

## Highlights

- **AI agent:** OpenAI-compatible providers, multiple conversations, Markdown
  rendering, local memory, an editable knowledge base, built-in plugins and
  skills, execution traces, file/PDF/image context, and opt-in web search.
- **Permission-aware actions:** calendar data is read only when enabled; event
  creation requires an explicit user request and the corresponding permission.
- **Weather:** Open-Meteo current conditions, hourly forecasts, rain hints,
  automatic location, manual city selection, and metric/imperial units.
- **Focus:** configurable Pomodoro work and break phases with persisted state.
- **Home dashboard:** media controls and lyrics, weather, calendar, Quick
  Launch, and battery levels for supported connected Bluetooth devices.
- **Custom layout:** choose which Home widgets and Bluetooth devices appear,
  reorder the dashboard, and resize the main and auxiliary panels.
- **Native macOS integration:** Calendar, Reminders, Location, Accessibility,
  media controls, HUD replacement, file shelf, and Keychain-backed credentials.

## AI Setup

1. Open **Settings > AI**.
2. Enable the AI agent.
3. Enter an OpenAI-compatible base URL, model name, and your own API key.
4. Enable calendar access, file tools, or web search only when needed.

No provider key is included in this repository or in release packages. DanShen
stores the configured API key in macOS Keychain and keeps conversations,
memories, and knowledge-base files on the local Mac.

## Build From Source

Prerequisites:

- macOS 15.6 or later for development
- Xcode 26 or later

```bash
git clone https://github.com/YL-SSSSu/DanShen.git
cd DanShen
./script/build_and_run.sh --verify
```

You can also open `boringNotch.xcodeproj` in Xcode and run the `boringNotch`
scheme.

## Privacy

- The repository and release archives contain no API keys, passwords, account
  data, chat history, calendar content, local documents, or personal knowledge
  base data.
- AI network requests are sent only to the provider configured by the user.
- Weather uses Open-Meteo; automatic location is optional. When Apple's geocoder cannot resolve a city name, the app may send the current coordinates to BigDataCloud's client-side reverse-geocoding endpoint as a fallback. Coordinates are not persisted by DanShen.
- Calendar, Reminders, Location, Accessibility, and Input Monitoring remain
  controlled by macOS permissions.

Please report security-sensitive problems through a private GitHub Security
Advisory instead of posting credentials or personal data in a public issue.

## Upstream And License

DanShen is an independent derivative of
[TheBoredTeam/boring.notch](https://github.com/TheBoredTeam/boring.notch). The
upstream project and its contributors retain attribution for the original work.
Additional third-party notices are listed in [THIRD_PARTY_LICENSES](THIRD_PARTY_LICENSES).

This repository is distributed under the [GNU GPL v3](LICENSE), consistent with
the upstream project. DanShen is not an official Boring Notch release and is not
endorsed by The Boring Team.
