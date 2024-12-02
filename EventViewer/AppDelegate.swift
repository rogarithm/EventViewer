//
//  AppDelegate.swift
//  EventViewer
//
//  Created by sehoon gim on 12/2/24.
//

import SwiftUI
import AppKit

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem?

     func applicationDidFinishLaunching(_ notification: Notification) {
         statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
         if let button = statusItem?.button {
             button.title = "Evt"
             button.action = #selector(showMenu)
         }

         let menu = NSMenu()
         menu.addItem(NSMenuItem(title: "Option 1", action: #selector(option1Action), keyEquivalent: "1"))
         menu.addItem(NSMenuItem(title: "Quit", action: #selector(quit), keyEquivalent: "q"))
         statusItem?.menu = menu
     }

     @objc func showMenu() {
         statusItem?.menu?.popUp(positioning: nil, at: NSEvent.mouseLocation, in: nil)
     }

     @objc func option1Action() {
         print("Option 1 selected!")
     }

     @objc func quit() {
         NSApp.terminate(nil)
     }
}
