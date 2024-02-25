//
//  LocalChatApp.swift
//  LocalChat
//
//  Created by Егор Никитин on 10/7/22.
//

import SwiftUI
import Observation

@Observable
class AppState {
  var loggin: Bool = false
  var connectionState: Bool = false
}

@main
struct LocalChatApp: App {
  @Environment(\.scenePhase) var scenePhase
  
  @State var appState = AppState()
  
  init() {
    Log.app.info("Application launched")
    UINavigationBar.appearance().scrollEdgeAppearance = UINavigationBarAppearance()
    ServicesCatalog.shared.initalSetup()
  }
  
  var body: some Scene {
    WindowGroup {
      VStack {
        if !appState.loggin {
          AuthAssembly().build(
            moduleOutput: nil,
            completion: nil
          )
          .transition(.opacity)
          .environment(appState)
        } else {
          RootAssembly().build(
            moduleOutput: nil,
            completion: nil
          )
          .transition(.opacity)
          .environment(appState)
        }
      }
      .animation(.easeIn, value: appState.loggin)
    }
    .onChange(of: scenePhase, { _, newValue in
      switch newValue {
      case .active:
        NetworkAssembly.shared.tcpTransport.start()
        Log.app.info("Application did enter forground")
      case .background:
        NetworkAssembly.shared.tcpTransport.sleep()
        Log.app.info("Application did enter background")
      default: break
      }
    })
  }
}
