//
//  MiniChallenge1App.swift
//  MiniChallenge1
//
//  Created by Julia Mendes on 29/08/22.
//

import SwiftUI

@main
struct MiniChallenge1App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
