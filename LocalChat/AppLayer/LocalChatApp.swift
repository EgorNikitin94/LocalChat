//
//  LocalChatApp.swift
//  LocalChat
//
//  Created by Егор Никитин on 10/7/22.
//

import SwiftUI

class LockalChatAppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
    if #available(iOS 15, *) {
      UINavigationBar.appearance().scrollEdgeAppearance = UINavigationBarAppearance()
    }
    return true
  }
}

@main
struct LocalChatApp: App {
  @UIApplicationDelegateAdaptor var delegate: LockalChatAppDelegate
  let persistenceController = PersistenceController.shared
  
  var body: some Scene {
    WindowGroup {
      NavigationStack {
        moduleAssembly.assemblyDialogsList()
      }
      //.environment(\.managedObjectContext, persistenceController.container.viewContext)
    }
  }
}
