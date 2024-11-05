//
//  SwiftDay7BasicsApp.swift
//  SwiftDay7Basics
//
//  Created by Bibek Bhujel on 18/10/2024.
//

import SwiftUI

@main
struct SwiftDay7BasicsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.modelContainer(for: ExpenseItem.self)
    }
}
