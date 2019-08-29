//
//  NotificationController.swift
//  MultiTimer WatchKit Extension
//
//  Created by Michael Salmon on 2019-08-26.
//  Copyright © 2019 mesme. All rights reserved.
//

import WatchKit
import SwiftUI
import UserNotifications

class NotificationController: WKUserNotificationHostingController<NotificationView> {

    var notificationID: String

    override init() {
        self.notificationID = ""
        super.init()
    }

    override var body: NotificationView {
        return NotificationView(id: notificationID)
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    override func didReceive(_ notification: UNNotification) {
        self.notificationID = notification.request.identifier
    }
}
