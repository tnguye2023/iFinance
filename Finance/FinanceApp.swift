//
//  FinanceApp.swift
//  Finance
//
//  Created by Tracy Nguyen on 12/12/22.
//

import SwiftUI
@main
struct FinanceApp: App {
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
