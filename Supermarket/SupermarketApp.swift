//
//  SupermarketApp.swift
//  Supermarket
//
//  Created by Luciano Nicolini on 08/05/2023.
//

import SwiftUI

@main
struct SupermarketApp: App {
    let persistenceController = PersistenceController.shared//.preview

    var body: some Scene {
        WindowGroup {
            CategoriaView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
