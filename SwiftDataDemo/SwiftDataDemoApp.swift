//
//  SwiftDataDemoApp.swift
//  SwiftDataDemo
//
//  Created by Mohammad Arsalan on 27/02/2024.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataDemoApp: App {
    var modelContainer: ModelContainer = {
        let schema = Schema([
            Expense.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            DashboardView()
        }
//        .modelContainer(for: [Expense.self])
        .modelContainer(modelContainer)
    }
}
