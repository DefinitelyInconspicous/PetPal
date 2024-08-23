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
    @Forever("cameraAccess") var cameraAccess = false
    @Forever("photoAccess") var photoAccess = false
    @Forever("pet") var pet = Pet(petName: "Rufus", petType: "Dog", breed: "Golden Retriever", weight: 10.0, diet: "Omnivorous", gender: .male, birthDate: Date.now, sterile: false, age: 0)
    @Forever("weightg") var weightG: [data] = []
    @Forever("medInfo") var medInfo = PetMedicalConditions(allergies: [], healthIssues: [], medications: [])
    var body: some View {
        NavigationView{
            List{
                Section{
                    Toggle("Toggle Reminders", isOn: $notifications)
                }
                Section{
                    Toggle("Allow Access To Camera", isOn: $cameraAccess)
                    Toggle("Allow Access To Photos", isOn: $photoAccess)
                }
                Section{
                    NavigationLink{
                        SlateBlankerView()
                    }label:{
                        Text("Blank the Slate")
                    }
                }
            }.onChange(of: notifications) { _ in
                if notifications == true{
                    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                        if success {
                            print("All set!")
                            let content = UNMutableNotificationContent()
                            content.title = "Spend time with your pet!"
                            content.subtitle = "It seems lonely!"
                            content.sound = UNNotificationSound.default
                            
                            // show this notification five seconds from now
                            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 43200, repeats: true)
                            
                            // choose a random identifier
                            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                            
                            // add our notification request
                            UNUserNotificationCenter.current().add(request)
                        } else if let error {
                            print(error.localizedDescription)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}
