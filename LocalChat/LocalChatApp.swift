//
//  LocalChatApp.swift
//  LocalChat
//
//  Created by Егор Никитин on 10/7/22.
//

import SwiftUI

@main
struct LocalChatApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
