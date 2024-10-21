//
//  ContentView.swift
//  SwiftDay7Basics
//
//  Created by Bibek Bhujel on 18/10/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var expenses = Expenses()
    @State private var showExpense = false
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path:$path){
            VStack{
                VStack{
                    Text("Personal Expense")
                        .font(.title2.bold())
                    List{
                        ForEach(expenses.items) {
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
                            ForEach(expenses.items) {
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
            .toolbar {
                NavigationLink(value: "addExpense") {
                    Text("Add Item")
                }
                    .navigationDestination(for: String.self) { _ in
                        AddView(expenses: expenses)
                    }
                
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
        expenses.items.remove(atOffsets: offsets)
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
