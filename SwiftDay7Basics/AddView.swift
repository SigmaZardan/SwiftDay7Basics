//
//  AddView.swift
//  SwiftDay7Basics
//
//  Created by Bibek Bhujel on 18/10/2024.
//

import SwiftUI

struct AddView: View {
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    @Environment(\.dismiss) var dismiss
    var expenses:Expenses
    let types = ["Personal", "Business"]
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text:$name)
                
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        type in
                        Text(type)
                    }
                }
                
                TextField("Amount", value: $amount, format: .currency(code:Locale.current.currency?.identifier  ?? "NEP"))
            }.navigationTitle("Add Expense")
                .toolbar {
                    Button("Add Expense", systemImage: "plus") {
                        let expense = ExpenseItem(name:name, type:type, amount:amount)
                        expenses.items.append(expense)
                        dismiss()
                    }
                }
        }
    }
}

#Preview {
    AddView(expenses: Expenses())
}
