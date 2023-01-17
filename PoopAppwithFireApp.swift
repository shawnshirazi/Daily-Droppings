//
//  PoopAppwithFireApp.swift
//  PoopAppwithFire
//
//  Created by Shawn Shirazi on 2/18/22.
//

import SwiftUI

@main
struct PoopAppwithFireApp: App {
    
    let persistentContainer = CoreDataManager.shared.persistenceContainer

    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistentContainer.viewContext)
        }
    }
}
