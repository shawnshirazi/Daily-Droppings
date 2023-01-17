//
//  ContentView.swift
//  PoopAppwithFire
//
//  Created by Shawn Shirazi on 2/18/22.
//

import SwiftUI

@available(iOS 15, *)
struct ContentView: View {
    
    let persistentContainer = CoreDataManager.shared.persistenceContainer

    var body: some View {
        TabView {
            weeklyCalenderView(calender: Calendar(identifier: .gregorian))
                .environment(\.managedObjectContext, persistentContainer.viewContext)
                .tabItem {
                    Image(systemName: "calendar")
                }
            
            PieChart()
                .environment(\.managedObjectContext, persistentContainer.viewContext)
                .tabItem {
                    Image(systemName: "list.dash")
                        .imageScale(.large)
                    

                }
        }
        .accentColor(.brown)

    }
}

@available(iOS 15, *)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
