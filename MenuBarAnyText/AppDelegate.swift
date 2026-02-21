//
//  AppDelegate.swift
//

import SwiftUI
import AppKit
//import ServiceManagement

class AppDelegate: NSObject, NSApplicationDelegate {
    static private(set) var instance: AppDelegate!
    private var settingsWindow: NSWindow?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        AppDelegate.instance = self
        // no Dock Icon
        NSApp.setActivationPolicy(.accessory)
    }
    
    func applicationDidBecomeActive(_ notification: Notification) {
    }
    
    // MARK: - Settings window
    @objc func openSettings() {
        if settingsWindow == nil {
            let showSettings = Binding<Bool>(get: { true }, set: { [weak self] _ in self?.settingsWindow?.close() })
            let view = SettingsView(showSettings: showSettings)
            let controller = NSHostingController(rootView: view)
            let window = NSWindow(contentViewController: controller)
            window.title = "Settings"
            window.styleMask = [.titled, .closable]
            window.setContentSize(NSSize(width: 200, height: 300))
            window.center()
            window.isReleasedWhenClosed = false
            window.level = .floating // keeps the window above normal windows (like Xcode) at all times
            settingsWindow = window
        }
        settingsWindow?.makeKeyAndOrderFront(nil)
        settingsWindow?.orderFrontRegardless() // brings it to the front even if another app is currently active
        NSApp.activate(ignoringOtherApps: true) // ensures the app itself gets focus
    }
}
