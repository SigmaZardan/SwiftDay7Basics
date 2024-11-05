//
//  AddView.swift
//  SwiftDay7Basics
//
//  Created by Bibek Bhujel on 18/10/2024.
//
import SwiftData
import SwiftUI

struct AddView: View {

    @Bindable var expense: ExpenseItem
    @Environment(\.dismiss) var dismiss
    let types = ["Personal", "Business"]
    
    var body: some View {
            Form {
                Section {
                    TextField("Name", text:$expense.name)
                }

                Section {
                    Picker("Type", selection: $expense.type) {
                        ForEach(types, id: \.self) {
                            type in
                            Text(type)
                        }
                    }
                }

                Section {
                    TextField("Amount", value: $expense.amount, format: .currency(code:Locale.current.currency?.identifier  ?? "NEP"))
                }
            }.navigationTitle("Add Expense")
                .toolbar {
                    Button("Add Expense", systemImage: "plus") {
                        dismiss()
                    }.disabled(expense.name.isEmpty)
                }
                .navigationBarBackButtonHidden(expense.name.isEmpty)
    }

}

#Preview {
    do {
        let configs = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: ExpenseItem.self, configurations: configs)
        let expense = ExpenseItem(name: "testItem", type: "Personal", amount: 12.89)

        return AddView(expense: expense)
            .modelContainer(container)
    }catch {
        return Text("Failed to create container: \(error.localizedDescription)")
    }
}
