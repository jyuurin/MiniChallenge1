//
//  SPorts.swift
//  SPorts
//
//  Created by Pedro Henrique Dias Hemmel de Oliveira Souza on 05/09/22.
//

import SwiftUI

@main
struct SPorts: App {
    
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            SplashScreen()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
    
    
}
