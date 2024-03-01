//
//  AddExpenseSheet.swift
//  SwiftDataDemo
//
//  Created by Mohammad Arsalan on 01/03/2024.
//

import SwiftUI


struct AddExpenseSheet: View {
    
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) private var dismiss
    
    @State private var name: String = ""
    @State private var date: Date = .now
    @State private var value: Double = 0
    @State private var selectedCategory: ExpenseCategory = .others
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Expense Name", text: $name)
                DatePicker("Date", selection: $date, displayedComponents: .date)
                TextField("Value", value: $value, format: .currency(code: "PKR"))
                    .keyboardType(.decimalPad)
                
                Picker(selection: $selectedCategory) {
                    ForEach(ExpenseCategory.allCases) { category in
                        
                        Text(category.title).tag(category)
                    }
                } label: {
                    Text("Category")
                }

            }
            .navigationTitle("New Expense")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button("Cancel") { dismiss() }
                }
                
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("Save") {
                        
                        let expense = Expense(name: name, date: date, value: value, category: selectedCategory)
                        context.insert(expense)

                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    AddExpenseSheet()
}
