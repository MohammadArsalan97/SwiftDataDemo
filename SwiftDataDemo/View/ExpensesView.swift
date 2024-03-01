//
//  ExpensesView.swift
//  SwiftDataDemo
//
//  Created by Mohammad Arsalan on 27/02/2024.
//

import SwiftUI
import SwiftData

struct ExpensesView: View {
    
    @Environment(\.modelContext) var context
    
    @Query(sort: \Expense.date) var expenses: [Expense]
    
    @State private var isShowingExpenseSheet = false
    @State private var expenseToEdit: Expense?
    @State private var sortOrder: SortOption = .dateByAsc
    
    var body: some View {
        
        NavigationStack {
            List {
                ForEach(expenses.sort(on: sortOrder)) { expense in
                    ExpenseCell(expense: expense)
                        .onTapGesture {
                            expenseToEdit = expense
                        }
                }
                .onDelete { indexSet in
                    indexSet.forEach { index in
                        context.delete(expenses[index])
                    }
                }
                
            }
            .navigationTitle("Expenses")
            .navigationBarTitleDisplayMode(.large)
            .sheet(isPresented: $isShowingExpenseSheet) { AddExpenseSheet() }
            .sheet(item: $expenseToEdit) { expense in
                UpdateExpenseSheet(expense: expense)
            }
            .toolbar {
                if !expenses.isEmpty {
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder) {
                            ForEach(SortOption.allCases, id: \.rawValue) {
                                Text($0.title)
                                    .tag($0)
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ExpensesView()
}

enum SortOption: String, CaseIterable {
    case dateByAsc
    case dateByDesc
    
    var title: String {
        switch self {
        case .dateByAsc:
             return "ASC"
        case .dateByDesc:
            return "DESC"
        }
    }
}

extension [Expense] {
    func sort(on option: SortOption) -> [Expense] {
        switch option {
        case .dateByAsc:
            self.sorted(by: {$0.date < $1.date })
        case .dateByDesc:
            self.sorted(by: {$0.date > $1.date })
        }
    }
}
