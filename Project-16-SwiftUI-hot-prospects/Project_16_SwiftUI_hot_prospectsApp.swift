//
//  Project_16_SwiftUI_hot_prospectsApp.swift
//  Project-16-SwiftUI-hot-prospects
//
//  Created by Kevin Cuadros on 14/04/25.
//

import SwiftUI
import SwiftData
import UserNotifications

@main
struct Project_16_SwiftUI_hot_prospectsApp: App {
    
    let notificationDelegate = NotificationDelegate()
    
    init() {
        UNUserNotificationCenter.current().delegate = notificationDelegate
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Prospect.self)
    }
}
