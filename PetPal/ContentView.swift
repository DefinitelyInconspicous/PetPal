//
//  ContentView.swift
//  PetPal
//
//  Created by Avyan Mehra on 20/7/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home_Page(weightData: [weightCell(weight: 0, date: 0)])
    }
}
#Preview {
    ContentView()
}
