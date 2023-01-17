//
//  CoreDataManager.swift
//  PoopAppwithFire
//
//  Created by Shawn Shirazi on 2/21/22.
//

import Foundation
import CoreData

class CoreDataManager {
    
    let persistenceContainer: NSPersistentContainer
    static let shared: CoreDataManager = CoreDataManager()
    
    private init() {
        
        persistenceContainer = NSPersistentContainer(name: "poop")
        persistenceContainer.loadPersistentStores { NSEntityDescription, error in
            if let error = error {
                fatalError("Unable to initialize Core Data \(error)")
            }
        }
    }
}
