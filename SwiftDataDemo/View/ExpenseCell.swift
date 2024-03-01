//
//  ExpenseCell.swift
//  SwiftDataDemo
//
//  Created by Mohammad Arsalan on 01/03/2024.
//

import SwiftUI


struct ExpenseCell: View {
    
    let expense: Expense
    
    var body: some View {
        HStack {
            
            GroupBox {
                Image(systemName: expense.category.icon)
                    .foregroundStyle(expense.category.iconColor)
            }
            
            VStack(alignment: .leading) {
                Text(expense.name)
                    .font(.headline)
                    .fontWeight(.semibold)
                Text(expense.date, format: .dateTime.month(.abbreviated).day())
                    .frame(width: 70, alignment: .leading)
                    .font(.subheadline)
                    .foregroundStyle(Color.gray)
            }
            
            
            Spacer()
            Text(expense.value, format: .currency(code: "PKR"))
                .font(.subheadline)
                .fontWeight(.medium)
        }
    }
}

#Preview {
    ExpenseCell(expense: Expense(name: "", date: .now, value: 0, category: .others))
}
