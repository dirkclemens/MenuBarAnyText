# MenuBarAnyText

A minimal simple showcase macOS menu bar app that displays a custom text label alongside the current time and a status indicator — built with SwiftUI.

## Features (examples, to be modified and/or enhanced)

- 📅 Shows a **calendar icon** with the current day number in the menu bar
- 🔴 Displays a **red status dot** for quick visibility
- 🕐 Shows the **current time** (locale-aware, 12h/24h) next to your custom text
- 🔄 Auto-updates every **minute**
- 🌗 Fully **dark/light mode** aware — text color adapts to the menu bar appearance
- ⚙️ Settings window accessible via the popover toolbar

## Requirements

- macOS 13 Ventura or later
- Xcode 15 or later

## Build & Run

1. Clone the repo:
   ```bash
   git clone https://github.com/yourusername/MenuBarAnyText.git
   ```
2. Open `MenuBarAnyText.xcodeproj` in Xcode.
3. Select your target (Mac) and hit **Run** (`⌘R`).

## Customization

The label text is currently hardcoded in `MenuBarAnyTextApp.swift`:

```swift
Image(nsImage: makeFullMenuBarImage(date: today, label: "any text to show"))
```

Replace `"any text to show"` with any string you like. Future versions will expose this via the Settings UI.

## Project Structure

```
MenuBarAnyText/
├── MenuBarAnyTextApp.swift   # App entry point, menu bar label & image rendering
├── AppDelegate.swift         # NSApplicationDelegate, settings window handling
├── ContentView.swift         # Popover content view
├── SettingsView.swift        # Settings window view
└── Assets.xcassets/          # App icon & accent color
```

## License

GNU