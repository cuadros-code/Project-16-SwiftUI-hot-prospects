//
//  NotificationDelegate.swift
//  Project-16-SwiftUI-hot-prospects
//
//  Created by Kevin Cuadros on 5/05/25.
//

import Foundation
import UserNotifications

class NotificationDelegate: NSObject, UNUserNotificationCenterDelegate {
    
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (
            UNNotificationPresentationOptions
        ) -> Void
    ) {
        print("Notification delegate")
        completionHandler([.badge, .banner, .sound])
    }
    
}
