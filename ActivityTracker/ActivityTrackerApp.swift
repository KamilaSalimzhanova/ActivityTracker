//
//  ActivityTrackerApp.swift
//  ActivityTracker
//
//  Created by kamila on 30.03.2025.
//

import SwiftUI

@main
struct ActivityTrackerApp: App {
    let dataStore = DataStore.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataStore.getContext())
                .environmentObject(ActivityStore(context: dataStore.getContext()))
        }
    }
}
