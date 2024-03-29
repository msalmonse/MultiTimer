//
//  Notify.swift
//  MultiTimer WatchKit Extension
//
//  Created by Michael Salmon on 2019-08-28.
//  Copyright © 2019 mesme. All rights reserved.
//

import UserNotifications

fileprivate let actionID = "TimerExpiered"
fileprivate let categoryID = "TimerExpiredCategory"

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
                if error != nil { print(error!) }
                if !granted {
                    authorized = .no
                } else {
                    authorized = .yes
                    categorize()
                }
            }
        )
    }
}

fileprivate func categorize() {
    var actions = [UNNotificationAction]()
    actions.append(UNNotificationAction(
            identifier: actionID,
            title: "",
            options: [.foreground]
        )
    )

    let category = UNNotificationCategory(
        identifier: categoryID,
        actions: actions,
        intentIdentifiers: [],
        options: []
    )

    UNUserNotificationCenter.current().setNotificationCategories([category])
}

fileprivate var timerCache = [String: CachedTimer]()

func sendNotification(for timer: SingleTimer) {
    if authorized == .unknown { authorizeNotifications() }
    if authorized != .yes { return }

    let id = timer.id.uuidString
    CachedTimer[id] = CachedTimer(timer)

    let content = UNMutableNotificationContent()
    content.title = String(format: "%.0f minute timer expired!", timer.duration/60.0)
    content.body = "Timer ended at: " + timer.formattedEndDate
    content.sound = .default
    content.categoryIdentifier = categoryID

    let request = UNNotificationRequest(identifier: id, content: content, trigger: nil)

    UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
            if error != nil { print(error!) }
        }
    )
}
