//
//  TestForTutuApp.swift
//  TestForTutu
//
//  Created by Михаил Кулагин on 08.10.2021.
//

import SwiftUI

@main
struct TestForTutuApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
