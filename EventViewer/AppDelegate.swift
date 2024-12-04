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
     }

     @objc func showMenu() {
         statusItem?.menu = NSMenu()
         
         let selectedDate = "2024-11-25"
         fetchEvents(for: selectedDate) { [weak self] events in
             DispatchQueue.main.async {
                 guard let self = self else { return }
                 if let events = events, !events.isEmpty {
                     for event in events {
                         let title = "\(event.startDateTime) - \(event.endDateTime): \(event.description)"
                         let menuItem = NSMenuItem(title: title, action: nil, keyEquivalent: "")
                         self.statusItem?.menu?.addItem(menuItem)
                     }
                 } else {
                     self.statusItem?.menu?.addItem(NSMenuItem(title: "No Events", action: nil, keyEquivalent: ""))
                 }
                 self.statusItem?.menu?.addItem(NSMenuItem.separator())
                 self.statusItem?.menu?.addItem(NSMenuItem(title: "Quit", action: #selector(self.quit), keyEquivalent: "q"))
                 self.statusItem?.menu?.popUp(positioning: nil, at: NSEvent.mouseLocation, in: nil)
             }
             
         }
     }

    func fetchEvents(for date: String, completion: @escaping ([EventGetResponse]?) -> Void) {
        guard let url = URL(string: "http://localhost:8080/events?date=\(date)") else {
            print("Invalid URL")
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching events: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }
            
            do {
                print(data)
                let events = try JSONDecoder().decode([EventGetResponse].self, from: data)
                completion(events)
            } catch {
                print("Failed to decode JSON: \(error)")
                completion(nil)
            }
        }
        
        task.resume()
    }
    
    @objc func quit() {
        NSApp.terminate(nil)
    }
}
