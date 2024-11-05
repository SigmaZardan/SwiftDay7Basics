//
//  ExpenseItem.swift
//  SwiftDay7Basics
//
//  Created by Bibek Bhujel on 18/10/2024.
//
import SwiftData
import SwiftUI

// We are adding identifiable to be 100 percent sure that the object of the structure will be unique.
//Therefore, we do not have to provide id in ForEach.
// UUID already conforms to Codable
//struct ExpenseItem:Identifiable, Codable{
//    var id = UUID()
//    let name: String
//    let type: String
//    let amount: Double
//}

//@Observable
//class Expenses{
//    var items = [ExpenseItem]() {
//        didSet {
//            if let encoded = try? JSONEncoder().encode(items) {
//                UserDefaults.standard.set(encoded, forKey: "Items")
//            }
//        }
//    }
//    init() {
//        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
//            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
//                items = decodedItems
//                return
//            }
//        }
//        items = []
//    }
//}

// how to use swiftdata ?
// creating model class expenseitem,
// Here, we are not creating observable class for expenses because we can directly query expenseitem objects from swiftdata

@Model
class ExpenseItem {
    var name: String
    var type: String 
    var amount: Double

    init(name: String, type: String, amount: Double) {
        self.name = name
        self.type = type
        self.amount = amount
    }
}

