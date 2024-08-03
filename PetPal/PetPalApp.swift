//
//  PetPalApp.swift
//  PetPal
//
//  Created by Avyan Mehra on 20/7/24.
//

import SwiftUI
func yearsBetweenDate(startDate: Date, endDate: Date) -> Int {

    let calendar = Calendar.current

    let components = calendar.dateComponents([.year], from: startDate, to: endDate)

    return components.year!
}
public enum Gender: String, CaseIterable, Identifiable, Codable {
    case male, female, nonbinary
    public var id: Self { self }
}
public struct Pet: Codable{
    var petName: String
    var petType: String
    var breed: String
    var weight: Double
    var diet: String
    var gender: Gender
    var birthDate: Date
    var sterile: Bool
    var age: Int
}
public struct PetMedicalConditions: Codable{
    var allergies: [String]
    var healthIssues: [String]
    var medications: [String]
}
@main
struct PetPalApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
