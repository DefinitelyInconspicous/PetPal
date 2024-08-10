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
                Toggle("Toggle Reminders", isOn: $notifications)
            }
        }
    }
}

#Preview {
    SettingsView()
}
