//
//  PlanTripApp.swift
//  PlanTrip
//
//  Created by Cynthia D'Phoenix on 8/14/25.
//

import SwiftUI

@main
struct PlanTripApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
