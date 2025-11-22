//
//  ROOMARTIA2App.swift
//  ROOMARTIA2
//
//  Created by ITSD on 2025-11-22.
//

import SwiftUI

import CoreData

@main
struct ROOMARTIA2App: App {
    @StateObject private var dataController = ARDataController()

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext,
                              dataController.container.viewContext)
                .environmentObject(dataController)
        }
    }
}

