//
//  NotificationManager.swift
//  Planto
//
//  Created by Yasmin Alhabib on 25/10/2025.
//
import Foundation
import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()
    
    private init() {}
    
    // Request permission from user
    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("✅ Notification permission granted")
            } else if let error = error {
                print("❌ Notification permission error: \(error.localizedDescription)")
            }
        }
    }
    
    // Schedule a notification for a plant
    func scheduleNotification(for plant: PlantReminder) {
        let content = UNMutableNotificationContent()
        content.title = "Planto"
        content.body = "Hey! let's water your plant"
        content.sound = .default
        
        // Calculate trigger based on watering days
        let interval = getIntervalInSeconds(from: plant.wateringDays)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: interval, repeats: true)
        
        // Create request with unique identifier (using plant ID)
        let request = UNNotificationRequest(
            identifier: plant.id.uuidString,
            content: content,
            trigger: trigger
        )
        
        // Schedule the notification
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("❌ Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("✅ Notification scheduled for \(plant.plantName)")
            }
        }
    }
    
    // Cancel notification for a specific plant
    func cancelNotification(for plantID: UUID) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [plantID.uuidString])
        print("🗑️ Notification cancelled for plant")
    }
    
    // Cancel all notifications
    func cancelAllNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        print("🗑️ All notifications cancelled")
    }
    
    // Convert watering days string to seconds
    private func getIntervalInSeconds(from wateringDays: String) -> TimeInterval {
        switch wateringDays {
        case "Every day":
            return 24 * 60 * 60  // 1 day in seconds
        case "Every 2 days":
            return 2 * 24 * 60 * 60  // 2 days
        case "Weekly":
            return 7 * 24 * 60 * 60  // 7 days
        default:
            return 24 * 60 * 60  // Default to 1 day
        }
    }
    
    // For testing: Schedule immediate notification (5 seconds from now)
    func scheduleTestNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Planto"
        content.body = "Hey! let's water your plant"
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("❌ Test notification error: \(error)")
            } else {
                print("✅ Test notification scheduled for 5 seconds")
            }
        }
    }
}
