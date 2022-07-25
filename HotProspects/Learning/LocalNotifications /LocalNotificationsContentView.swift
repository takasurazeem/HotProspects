//
//  LocalNotificationsContentView.swift
//  HotProspects
//
//  Created by Takasur Azeem on 25/07/2022.
//

import SwiftUI
import UserNotifications

struct LocalNotificationsContentView: View {
    var body: some View {
        VStack {
            Button("Request Permission") {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        print("All set")
                    } else if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }
            
            Button("Schedule Notification") {
                let content = UNMutableNotificationContent()
                content.title = "Greet people with smile."
                content.subtitle = "Because it's sunnah."
                content.sound = .defaultCritical
                
                // show this notification five seconds from now
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                
                // choose a randim identifer
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                
                // add the notification request
                UNUserNotificationCenter.current().add(request)
            }
        }
    }
}

struct LocalNotificationsContentView_Previews: PreviewProvider {
    static var previews: some View {
        LocalNotificationsContentView()
    }
}
