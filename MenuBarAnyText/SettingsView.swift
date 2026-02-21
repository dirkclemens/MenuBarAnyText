//
//  SettingsView.swift
//

import SwiftUI

struct SettingsView: View {
    @Binding var showSettings: Bool
    var body: some View {
        VStack {
            Text("SettingsView")
                .padding()
        }
        .padding()
        .frame(minWidth: 300, minHeight: 200)
    }
}
