//
//  ContentView.swift
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world!")
            }
                        
            Spacer()
            
            Divider().frame(height: 1).background(.windowBackground)

            HStack {
                Button(action: { AppDelegate.instance.openSettings() }) {
                    Image(systemName: "gearshape")
                        .font(.system(size: 12))
                }
                .buttonStyle(.glass)
                .foregroundColor(.secondary)
                
                Spacer()
                
                Button(action: { NSApp.terminate(nil) }) {
                    Image(systemName: "power")
                        .font(.system(size: 12))
                }
                .buttonStyle(.glass)
                .foregroundColor(.secondary)
            }
            .frame(height: 30)
        }
        .padding()
        .frame(minWidth: 100, minHeight: 200)
    }
}
