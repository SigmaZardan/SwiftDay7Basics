//
//  ContentView.swift
//  SwiftDay7Basics
//
//  Created by Bibek Bhujel on 18/10/2024.
//
import SwiftData
import SwiftUI

struct ContentView: View {

    @Query var expenses: [ExpenseItem]
    @State private var path = [ExpenseItem]()
    @Environment(\.modelContext) var modelContext

    var body: some View {
        NavigationStack(path:$path){
            VStack{
                VStack{
                    Text("Personal Expense")
                        .font(.title2.bold())
                    List{
                        ForEach(expenses) {
                            item in
                            if item.type == "Personal" {
                                DisplayExpenseItem(itemName: item.name, itemType: item.type, itemAmount: item.amount, amountForegroundColor: addAmountForegroundColor(amount: item.amount))
                            }
                        }
                        .onDelete(perform: removeItems)
                    }
                }
                    VStack {
                        Text("Business Expenses")
                            .font(.title2.bold())
                        List {
                            ForEach(expenses) {
                                item in
                                if item.type == "Business" {
                                    DisplayExpenseItem(itemName: item.name, itemType: item.type, itemAmount: item.amount, amountForegroundColor: addAmountForegroundColor(amount: item.amount))
                                }
                            }.onDelete(perform: removeItems)
                        }
                    }
            }
            .navigationTitle("IExpense")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: ExpenseItem.self) { expense in
                AddView(expense: expense)
            }
            .toolbar {
                Button("Add expense", systemImage: "plus") {
                    let expense = ExpenseItem(name: "", type: "Personal", amount: 0.0)
                    path = [expense]
                    modelContext.insert(expense)
                }
            }
            .onAppear(perform: deleteEmptyExpense)
        }
    }


    func deleteEmptyExpense() {
        for expense in expenses {
            if expense.name.isEmpty {
                modelContext.delete(expense)
            }
        }
    }

    func addAmountForegroundColor(amount:Double) -> Color {
        return if(amount < 10) {
            Color.red
        }
        else if(amount > 100) {
            Color.green
        }
        else {
            Color.black
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        for offset in offsets {
            let expense = expenses[offset]
            modelContext.delete(expense)
        }
    }
}



struct DisplayExpenseItem: View {
    let itemName:String
    let itemType: String
    let itemAmount: Double
    let amountForegroundColor:Color
    var body: some View {
        HStack {
            VStack(alignment:.leading){
                Text(itemName)
                    .font(.headline)
                Text(itemType)
            }
            Spacer()
            Text(itemAmount,format:.currency(code:Locale.current.currency?.identifier  ?? "NEP"))
                .foregroundStyle(amountForegroundColor)
        }
    }
}

#Preview {
    ContentView()
}
