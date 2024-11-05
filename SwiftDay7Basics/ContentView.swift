//
//  ContentView.swift
//  SwiftDay7Basics
//
//  Created by Bibek Bhujel on 18/10/2024.
//
import SwiftData
import SwiftUI

struct ContentView: View {

    @State private var path = [ExpenseItem]()
    @Environment(\.modelContext) var modelContext

    @State private var sortOrder = [
        SortDescriptor(\ExpenseItem.name),
        SortDescriptor(\ExpenseItem.amount),
    ]

    var body: some View {
        NavigationStack(path:$path){
            DisplayExpensesView(sortOrder: sortOrder)
            .navigationTitle("IExpense")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: ExpenseItem.self) { expense in
                AddView(expense: expense)
            }
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("Add expense", systemImage: "plus") {
                        let expense = ExpenseItem(name: "", type: "Personal", amount: 0.0)
                        path = [expense]
                        modelContext.insert(expense)
                    }
                }

                ToolbarItemGroup(placement: .topBarLeading) {
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder) {
                            Text("Sort by Name")
                                .tag(
                                    [
                                        SortDescriptor(\ExpenseItem.name),
                                        SortDescriptor(\ExpenseItem.amount),
                                    ]
                                )

                            Text("Sor by Amount")
                                .tag(
                                    [
                                        SortDescriptor(\ExpenseItem.amount),
                                        SortDescriptor(\ExpenseItem.name),
                                    ]
                                )
                        }
                    }

                }
            }
        }
    }

}

struct DisplayExpensesView: View {
    @Query var expenses: [ExpenseItem]
    @Environment(\.modelContext) var modelContext

    init(sortOrder: [SortDescriptor<ExpenseItem>]) {
        _expenses = Query(sort: sortOrder)
    }

    var body: some View {
        VStack{
            VStack{
                Text("Personal Expense")
                    .font(.title2.bold())
                List{
                    ForEach(expenses) {
                        item in
                        if item.type == "Personal" {
                            DisplayExpenseCardView(itemName: item.name, itemType: item.type, itemAmount: item.amount, amountForegroundColor: addAmountForegroundColor(amount: item.amount))
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
                                DisplayExpenseCardView(itemName: item.name, itemType: item.type, itemAmount: item.amount, amountForegroundColor: addAmountForegroundColor(amount: item.amount))
                            }
                        }.onDelete(perform: removeItems)
                    }
                }
        }
    }

    func removeItems(at offsets: IndexSet) {
        for offset in offsets {
            let expense = expenses[offset]
            modelContext.delete(expense)
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
}


struct DisplayExpenseCardView: View {
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
