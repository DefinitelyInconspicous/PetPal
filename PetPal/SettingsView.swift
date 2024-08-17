//
//  SettingsView.swift
//  PetPal
//
//  Created by Ishika Tholia on 27/7/24.
//

import SwiftUI
import Forever

struct SettingsView: View {

    @Forever("notifications") var notifications = false
    var body: some View {
        NavigationView{
            List{
                Section{
                    Toggle("Toggle Reminders", isOn: $notifications)
                }
                Section{
                    Toggle("Allow Access To Camera", isOn: $notifications)
                    Toggle("Allow Access To Photos", isOn: $notifications)
                }
            }.onChange(of: notifications) { _ in
                
                    let content = UNMutableNotificationContent()
                    content.title = "Feed the cat"
                    content.subtitle = "It looks hungry"
                    content.sound = UNNotificationSound.default

                    // show this notification five seconds from now
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 7200, repeats: true)

                    // choose a random identifier
                    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

                    // add our notification request
                    UNUserNotificationCenter.current().add(request)
                }
        }
    }
}

#Preview {
    SettingsView()
}
