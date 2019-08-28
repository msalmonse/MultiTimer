//
//  Notify.swift
//  MultiTimer WatchKit Extension
//
//  Created by Michael Salmon on 2019-08-28.
//  Copyright © 2019 mesme. All rights reserved.
//

import UserNotifications

enum NotificationsAuthorized {
    case no, maybe, unknown, yes
}

fileprivate var authorized: NotificationsAuthorized = .unknown

func authorizeNotifications() {
    if authorized == .unknown {
        authorized = .maybe
        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert, .sound],
            completionHandler: { (granted, error) in
                authorized = granted ? .yes : .no
                if error != nil { print(error!) }
            }
        )
        UNUserNotificationCenter.current().getNotificationCategories(
            completionHandler: { print($0) }
        )
    }
}

func sendNotification(for timer: SingleTimer) {
    if authorized == .unknown { authorizeNotifications() }
    if authorized != .yes { return }

    let id = timer.id.uuidString

    let formatter = DateFormatter()
    formatter.dateStyle = .none
    formatter.timeStyle = .medium

    let content = UNMutableNotificationContent()
    content.title = String(format: "%.0f minute timer expired!", timer.duration/60.0)
    content.body = "Timer ended at: " + formatter.string(from: timer.endDate)
    content.sound = .default

    let request = UNNotificationRequest(identifier: id, content: content, trigger: nil)

    UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
            if error != nil { print(error!) }
        }
    )
}
