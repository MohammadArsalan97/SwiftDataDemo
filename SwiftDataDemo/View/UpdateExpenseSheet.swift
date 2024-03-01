//
//  UpdateExpenseSheet.swift
//  SwiftDataDemo
//
//  Created by Mohammad Arsalan on 01/03/2024.
//

import SwiftUI

struct UpdateExpenseSheet: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @Bindable var expense: Expense
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Expense Name", text: $expense.name)
                DatePicker("Date", selection: $expense.date, displayedComponents: .date)
                TextField("Value", value: $expense.value, format: .currency(code: "PKR"))
                    .keyboardType(.decimalPad)
                Picker(selection: $expense.category) {
                    ForEach(ExpenseCategory.allCases) { category in
                        
                        Text(category.title).tag(category)
                    }
                } label: {
                    Text("Category")
                }
            }
            .navigationTitle("Update Expense")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button("Done") { dismiss() }
                }
            }
        }
    }
}

#Preview {
    UpdateExpenseSheet(expense: Expense(name: "", date: .now, value: 0, category: .others))
}
