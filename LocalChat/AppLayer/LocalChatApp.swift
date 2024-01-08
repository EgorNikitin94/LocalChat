//
//  LocalChatApp.swift
//  LocalChat
//
//  Created by Егор Никитин on 10/7/22.
//

import SwiftUI
import Observation

class LockalChatAppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
    if #available(iOS 15, *) {
      UINavigationBar.appearance().scrollEdgeAppearance = UINavigationBarAppearance()
    }
    
    TcpTransport.shared.setupConnection()
    return true
  }
}

@Observable
class AppState {
  var loggin: Bool = false
  var connectionState: Bool = false
}

@main
struct LocalChatApp: App {
  @UIApplicationDelegateAdaptor var delegate: LockalChatAppDelegate
  
  @State var appState = AppState()
  
  var body: some Scene {
    WindowGroup {
      RootAssembly().build(
        moduleOutput: nil,
        completion: nil
      )
    }
    .environment(appState)
  }
}
