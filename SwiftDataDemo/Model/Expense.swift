//
//  Expense.swift
//  SwiftDataDemo
//
//  Created by Mohammad Arsalan on 27/02/2024.
//

import Foundation
import SwiftUI
import SwiftData

@Model
class Expense {
    var name: String
    var date: Date
    var value: Double
    var category: ExpenseCategory
    
    init(name: String, date: Date, value: Double, category: ExpenseCategory) {
        self.name = name
        self.date = date
        self.value = value
        self.category = category
    }
}

enum ExpenseCategory: String, CaseIterable, Identifiable, Codable {
    
    var id : String { UUID().uuidString }
    case medical
    case shopping
    case food
    case others
    
    var title: String {
        switch self {
        case .medical: return "Medical"
        case .shopping: return "Shopping"
        case .food: return "Food"
        case .others: return "Others"
        }
    }
    
    var icon: String {
        switch self {
        case .medical: return "stethoscope"
        case .shopping: return "bag"
        case .food: return "takeoutbag.and.cup.and.straw"
        case .others: return "list.bullet.clipboard"
        }
    }
    
    var iconColor: Color {
        switch self {
        case .medical: return .purple
        case .shopping: return .pink
        case .food: return .green
        case .others: return .orange
        }
    }
    
    func calculateTotalExpenseAmount(expenses: [Expense]) -> Double {
        expenses.filter {$0.category == self}.reduce(0.0) { $0 + ($1.value) }
    }
}

