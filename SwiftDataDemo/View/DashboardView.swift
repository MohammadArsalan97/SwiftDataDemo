//
//  DashboardView.swift
//  SwiftDataDemo
//
//  Created by Mohammad Arsalan on 01/03/2024.
//

import SwiftUI
import SwiftData

struct DashboardView: View {
    
    @Environment(\.modelContext) var context
    
    @Query(sort: \Expense.date, order: .reverse) var expenses: [Expense]
    
    @State private var isShowingExpenseSheet = false
    @State private var isShowingExpenses = false
    @State private var expenseToEdit: Expense?
    
    let categories = ExpenseCategory.allCases
    
    var recentExpenses: [Expense] { return Array(expenses.prefix(upTo: 3)) }
    
    var totalExpenseAmount: Double { return expenses.reduce(0.0) { $0 + ($1.value) } }
    
    
    var body: some View {
        NavigationStack {
            
            Section {
                
                List {
                    if !expenses.isEmpty {
                        Section("Categories") {
                            
                            VStack {
                                HStack {
                                    CardView(category: categories[0])
                                    CardView(category: categories[1])
                                }
                                HStack {
                                    
                                    CardView(category: categories[2])
                                    CardView(category: categories[3])
                                    
                                }
                            }
                        }
                        Section {
                            ForEach(recentExpenses) { expense in
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
                        } header: {
                            HStack {
                                Text("Recent Expenses")
                                Spacer()
                                Button {
                                    isShowingExpenses = true
                                } label: {
                                    
                                    HStack {
                                        Text("View All").fontWeight(.bold)
                                        Image(systemName: "chevron.forward")
                                    }
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(Color.gray)
                                    
                                }
                            }
                            
                        }
                    }
                    
                }
                .navigationTitle("Hello Arsalan! 😊")
                .navigationBarTitleDisplayMode(.large)
                .sheet(isPresented: $isShowingExpenseSheet) { AddExpenseSheet() }
                .sheet(item: $expenseToEdit) { expense in
                    UpdateExpenseSheet(expense: expense)
                }
                .sheet(isPresented: $isShowingExpenses, content: {
                    ExpensesView()
                })
                .toolbar {
                    if !expenses.isEmpty {
                        Button("Add Expense", systemImage: "plus") {
                            isShowingExpenseSheet = true
                        }
                    }
                }
                .overlay {
                    if expenses.isEmpty {
                        ContentUnavailableView(label: {
                            Label("No Expenses", systemImage: "list.bullet.rectangle.portrait")
                        }, description: {
                            Text("Start adding expenses to see your list.")
                        }, actions: {
                            Button("Add Expense") {
                                isShowingExpenseSheet = true
                            }
                        })
                    }
                }
            } header: {
                if !expenses.isEmpty {
                    GroupBox(label: Text("Total Expenses"), content: {
                        Text(totalExpenseAmount, format: .currency(code: "PKR"))
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(Color.mint)
                    })
                    .padding()
                }
                
            }
        }
    }
}

#Preview {
    DashboardView()
}
