//
//  MenuBarAnyTextApp.swift
//

import SwiftUI

@main
struct MenuBarAnyTextApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @State private var showSettings = false
    @State private var today = Date()

    var body: some Scene {
        MenuBarExtra {
            ContentView()
        } label: {
            HStack() {
                Image(nsImage: makeFullMenuBarImage(date: today, label: "any text to show"))
            }
            .task {
                while true {
                    // sleep until the next minute to update the time display
                    try? await Task.sleep(for: .seconds(1 * 60))
                    today = Date()
                }
            }
        }
        .menuBarExtraStyle(.window)
    }
}

/// Renders icon + red dot + text into a single non-template NSImage for the menu bar.
func makeFullMenuBarImage(date: Date = Date(), label: String) -> NSImage {
    let height: CGFloat = 22
    let dotSize: CGFloat = 8
    let iconSize: CGFloat = 20
    let spacing: CGFloat = 4
    let fontSize: CGFloat = 14

    // Measure text
    let formatter = DateFormatter()
    formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "j:mm", options: 0, locale: Locale.current)
    let labelStr = "\(formatter.string(from: date)) \(label)"
    let attrs: [NSAttributedString.Key: Any] = [
        .font: NSFont.systemFont(ofSize: fontSize, weight: .regular)
    ]
    let textSize = (labelStr as NSString).size(withAttributes: attrs)

    // Total width: icon + spacing + dot + spacing + text
    let totalWidth = iconSize + spacing + dotSize + spacing + textSize.width + 4
    let imageSize = NSSize(width: totalWidth, height: height)

    let image = NSImage(size: imageSize)
    image.lockFocus()
    defer { image.unlockFocus() }

    // Resolve adaptive colors against the current system appearance
    let appearance = NSApp.effectiveAppearance
    var resolvedLabelColor = NSColor.white // default fallback
    appearance.performAsCurrentDrawingAppearance {
        resolvedLabelColor = NSColor.yellow //NSColor.labelColor.withAlphaComponent(1)
    }

    // Draw the day icon (draw raw, not via template image)
    let iconRect = NSRect(x: 0, y: (height - iconSize) / 2, width: iconSize, height: iconSize)
    let base = NSImage(named: NSImage.Name("AnyTextFrame"))
        ?? NSImage(systemSymbolName: "macwindow", accessibilityDescription: "AnyText")
        ?? NSImage()
    base.draw(in: iconRect, from: .zero, operation: .sourceOver, fraction: 1.0)

    let day = "\(Calendar.current.component(.day, from: date))"
    let paragraph = NSMutableParagraphStyle()
    paragraph.alignment = .center
    let iconTextAttrs: [NSAttributedString.Key: Any] = [
        .font: NSFont.systemFont(ofSize: 10, weight: .semibold),
        .foregroundColor: resolvedLabelColor,
        .paragraphStyle: paragraph
    ]
    let dayStr = NSAttributedString(string: day, attributes: iconTextAttrs)
    let dayStrSize = dayStr.size()
    dayStr.draw(in: NSRect(
        x: (iconSize - dayStrSize.width) / 2,
        y: (height - dayStrSize.height) / 2 - 1,
        width: dayStrSize.width,
        height: dayStrSize.height
    ))

    // Draw red dot
    let dotX = iconSize + spacing
    let dotRect = NSRect(x: dotX, y: (height - dotSize) / 2, width: dotSize, height: dotSize)
    NSColor.red.setFill()
    NSBezierPath(ovalIn: dotRect).fill()

    // Draw text in adaptive color (matches menu bar light/dark)
    let textAttrs: [NSAttributedString.Key: Any] = [
        .font: NSFont.systemFont(ofSize: 13, weight: .regular),
        .foregroundColor: resolvedLabelColor
    ]
    let textX = dotX + dotSize + spacing
    let textRect = NSRect(x: textX, y: (height - textSize.height) / 2 + 1, width: textSize.width + 4, height: textSize.height)
    (labelStr as NSString).draw(in: textRect, withAttributes: textAttrs)

    // NOT a template — preserves the red dot color
    image.isTemplate = false
    return image
}

