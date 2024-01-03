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
    
    let tcpTransport = TcpConnection()
    tcpTransport.connect()
    return true
  }
}

@main
struct LocalChatApp: App {
  @UIApplicationDelegateAdaptor var delegate: LockalChatAppDelegate
  
  var body: some Scene {
    WindowGroup {
      RootView()
    }
  }
}


struct RootView: View {
  enum TabBarState {
    case contacts
    case chats
    case profile
  }
  
  @State var state: TabBarState = .chats
  
  @State var isContacts: Bool = false
  @State var isChats: Bool = false
  @State var isSettings: Bool = false
  
  @Environment(\.colorScheme) private var colorScheme
  
  var body: some View {
    NavigationStack {
      VStack(spacing: .zero) {
        
        switch state {
        case .contacts:
          Text("Contacts")
            .frame(maxHeight: .infinity)
        case .chats:
          DialogsListAssembly().build(moduleOutput: nil, completion: nil)
            .frame(maxHeight: .infinity)
        case .profile:
          ProfileAssembly().build(moduleOutput: nil, completion: nil)
            .frame(maxHeight: .infinity)
        }
        
        HStack(alignment: .top) {
          Button(action: {
            state = .contacts
            isContacts.toggle()
          }, label: {
            VStack {
              Image(systemName: "person.fill")
                .resizable()
                .frame(width: 22, height: 22)
                .modify({ view in
                  if #available(iOS 17.0, *) {
                    view
                      .symbolEffect(.bounce.down, value: isContacts)
                  }
                })
              Text("Contacts")
                .font(.system(size: 14))
            }
          })
          .foregroundColor(state == .contacts ? .blue : .gray)
          .padding(.top, 5)
          .padding(.leading, 40)
          .padding(.trailing, 5)
          .padding(.bottom, 25)
          
          Spacer()
          
          Button(action: {
            state = .chats
            isChats.toggle()
          }, label: {
            VStack {
              Image(systemName: "message.fill")
                .resizable()
                .frame(width: 22, height: 22)
                .modify({ view in
                  if #available(iOS 17.0, *) {
                    view
                      .symbolEffect(.bounce.down, value: isChats)
                  }
                })
              Text("Chats")
                .font(.system(size: 14))
            }
          })
          .foregroundColor(state == .chats ? .blue : .gray)
          .padding(.top, 5)
          .padding(.horizontal, 5)
          .padding(.bottom, 25)
          
          Spacer()
          
          Button(action: {
            state = .profile
            isSettings.toggle()
          }, label: {
            VStack {
              Image(systemName: "gear")
                .resizable()
                .frame(width: 22, height: 22)
                .modify({ view in
                  if #available(iOS 17.0, *) {
                    view
                      .symbolEffect(.bounce.down, value: isSettings)
                  }
                })
              Text("Settings")
                .font(.system(size: 14))
            }
          })
          .foregroundColor(state == .profile ? .blue : .gray)
          .padding(.top, 5)
          .padding(.trailing, 40)
          .padding(.leading, 5)
          .padding(.bottom, 25)
        }
        .background(colorScheme == .light ? Color(UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 0.7)) : Color(uiColor: .systemGray6))
        
      }
      .ignoresSafeArea(edges: .bottom)
    }
  }
}

extension View {
  func modify<T: View>(@ViewBuilder _ modifier: (Self) -> T) -> some View {
    return modifier(self)
  }
}


#Preview {
  RootView()
    .preferredColorScheme(.dark)
}
