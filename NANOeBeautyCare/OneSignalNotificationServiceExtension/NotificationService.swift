//
//  NotificationService.swift
//  OneSignalNotificationServiceExtension
//
//  Created by Dom on 23/01/2021.
//  Copyright © 2021 ToDu ForSharing Company Limited. All rights reserved.
//

import UserNotifications

import OneSignal

class NotificationService: UNNotificationServiceExtension {
    
    var contentHandler: ((UNNotificationContent) -> Void)?
    var receivedRequest: UNNotificationRequest!
    var bestAttemptContent: UNMutableNotificationContent?
    
    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.receivedRequest = request;
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
        
        if let bestAttemptContent = bestAttemptContent {
            OneSignal.didReceiveNotificationExtensionRequest(self.receivedRequest, with: self.bestAttemptContent)
            //            receivedRequest.content.
            //            if let userDefaults = UserDefaults(suiteName: "group.com.nanosoft.pkcongnghe.onesignal") {
            //                let value1 = userDefaults.string(forKey: "key1")
            //                let value2 = userDefaults.string(forKey: "key2")
            //                print("NSE value1 = ", value1?.description ?? "No value")
            //                print("NSE value2 = ", value2?.description ?? "No value")
            bestAttemptContent.title = receivedRequest.content.title
            bestAttemptContent.body = receivedRequest.content.body
            //            }
            contentHandler(bestAttemptContent)
        }
    }
    
    override func serviceExtensionTimeWillExpire() {
        // Called just before the extension will be terminated by the system.
        // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
            OneSignal.serviceExtensionTimeWillExpireRequest(self.receivedRequest, with: self.bestAttemptContent)
            contentHandler(bestAttemptContent)
        }
    }
    
}
