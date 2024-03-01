//
//  CardView.swift
//  SwiftDataDemo
//
//  Created by Mohammad Arsalan on 01/03/2024.
//

import SwiftUI
import SwiftData

struct CardView: View {
    
    @Query var expenses: [Expense]
    
    @State var category: ExpenseCategory
    
    var body: some View {
        GroupBox {
            HStack {
                VStack(alignment: .leading) {
                    Text("\(category.title)")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    Text(category.calculateTotalExpenseAmount(expenses: expenses), format: .currency(code: "PKR"))
                        .font(.caption)
                }
                Spacer()
            }
            
        } label: {
            GroupBox {
                Image(systemName: category.icon)
                    .foregroundStyle(category.iconColor)
            }
            
        }
    }
}

#Preview {
    CardView(category: .others)
}
