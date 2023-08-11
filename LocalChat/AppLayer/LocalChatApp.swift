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
  //@StateObject var router: AppRouter = AppRouter()
  
  var body: some Scene {
    WindowGroup {
      NavigationStack {
        DialogsListAssembly().build(moduleOutput: nil, completion: nil)
//        //moduleAssembly.assemblyDialogsList()
//        VStack() {
//          EmptyView()
//        }
//        .onAppear {
//          router.pushInitialView()
//        }
//          .navigationDestination(for: Screen.self) {screen in
//            switch screen {
//            case .auth:
//              router.pushAuthView()
//            case .dialogsList:
//              router.pushDialogsList()
//            case .profile:
//              moduleAssembly.assemblyProfile()
//            case .conversation:
//              //moduleAssembly.assemblyConversation(for: dialog)
//              moduleAssembly.assemblyProfile()
//            case .chatInfo:
//              moduleAssembly.assemblyProfile()
//            }
//          }
      }
      //.environment(\.managedObjectContext, persistenceController.container.viewContext)
    }
  }
}
