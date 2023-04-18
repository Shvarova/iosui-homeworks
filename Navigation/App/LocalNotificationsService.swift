//
//  LocalNotificationsService.swift
//  Navigation
//
//  Created by Дина Шварова on 18.04.2023.
//

import UIKit
import UserNotifications

class LocalNotificationsService {
    static let shared = LocalNotificationsService()
    private let notificationCenter = UNUserNotificationCenter.current()
    private init() {}
    
    func registeForLatestUpdatesIfPossible() {
        notificationCenter.getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .authorized:
                self.dispatchNotification()
            case .notDetermined:
                self.notificationCenter.requestAuthorization(options: [.sound, .badge, .provisional]) {
                    (granted, error) in
                    guard granted else { return }
                    DispatchQueue.main.async {
                        UIApplication.shared.registerForRemoteNotifications()
                    }
                    self.dispatchNotification()
                }
            default:
                return
            }
        }
    }
    
    private func dispatchNotification() {
        let id = "LocalNotification"
        let title = "Посмотрите последние обновления"
        let hour = 19
        let minute = 00
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.sound = .default
        
        let calendar = Calendar.current
        var dateComponents = DateComponents(calendar: calendar, timeZone: .current)
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request =  UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [id])
        notificationCenter.add(request)
    }
}
