//
//  EventViewerApp.swift
//  EventViewer
//
//  Created by sehoon gim on 12/2/24.
//

import SwiftUI
import AppKit

@main
struct EventViewerApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        Settings {
            Text("App Settings")
        }
    }
}
