//
//  NotificationManager.swift
//  ChallengeMacarronada
//
//  Created by thaxz on 01/06/23.
//

import Foundation
import UserNotifications

class NotificationManager {
    
    static let shared = NotificationManager()
    private init () {}

    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if let error = error {
                print("Error: \(error)")
            } else {
                print("Success")
            }
        }
    }

    func scheduleNotification(title: String, subtitle: String, hour: Int, minute: Int, imageName : String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.sound = .default
        content.categoryIdentifier = "NOTIFICATION_CAT"
        
        if let url = Bundle.main.url(forResource: "ilustrações bell-0\(imageName)", withExtension: "png"){
            if let attachment = try? UNNotificationAttachment(identifier: "image", url: url, options: nil){
                content.attachments = [attachment]
            }
        }
        
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger)
        
        let dismiss = UNNotificationAction(identifier: "DISMISS_ACTION", title: "Fechar", options: [])
        
        let generalCategory = UNNotificationCategory(identifier: "NOTIFICATION_CAT", actions: [dismiss], intentIdentifiers: [], options: [])
        
        UNUserNotificationCenter.current().add(request)
        UNUserNotificationCenter.current().setNotificationCategories([generalCategory])
    }
    
    
}
