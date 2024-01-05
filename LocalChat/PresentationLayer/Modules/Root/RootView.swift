//
//  RootView.swift
//  LocalChat
//
//  Created by Егор Никитин on 1/7/24.
//

import SwiftUI

class RootViewTabItem: ObservableObject, Identifiable {
  let id: Int
  let tabBarType: TabBarItemType
  let title: String
  let imageName: String
  @Published var animationTrigger: Bool = false
  
  enum TabBarItemType: Int {
    case contacts
    case chats
    case profile
  }
  
  init(type: TabBarItemType) {
    self.id = type.rawValue
    self.tabBarType = type
    self.title = if type == .contacts {
      "Contacts"
    } else if type == .chats {
      "Chats"
    } else {
      "Settings"
    }
    
    self.imageName = if type == .contacts {
      "person.fill"
    } else if type == .chats {
      "message.fill"
    } else {
      "gear"
    }
  }
}

struct RootView: View {
  @State private var state: RootViewTabItem.TabBarItemType = .chats
  @State private var isPortretOrientation = true
  private let orientationHasChanged = NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)
  
  @State private var tabBarItems: [RootViewTabItem] = [
    RootViewTabItem(type: .contacts),
    RootViewTabItem(type: .chats),
    RootViewTabItem(type: .profile)
  ]
  
  @Environment(\.colorScheme) private var colorScheme
  
  var body: some View {
    NavigationStack {
      VStack(spacing: .zero) {
        
        switch state {
        case .contacts:
          Text("Contacts")
            .frame(maxHeight: .infinity)
            .navigationTitle("Contacts")
            .navigationBarTitleDisplayMode(.inline)
        case .chats:
          DialogsListAssembly().build(moduleOutput: nil, completion: nil)
            .frame(maxHeight: .infinity)
        case .profile:
          ProfileAssembly().build(moduleOutput: nil, completion: nil)
            .frame(maxHeight: .infinity)
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
        }
        
        HStack(alignment: .top) {
          ForEach(tabBarItems) { item in
            Button(action: {
              state = item.tabBarType
              item.animationTrigger.toggle()
            }, label: {
              let Layout = isPortretOrientation ? AnyLayout(VStackLayout()) : AnyLayout(HStackLayout())
              Layout {
                Image(systemName: item.imageName)
                  .resizable()
                  .frame(width: 21, height: 21)
                  .modify({ view in
                    if #available(iOS 17.0, *) {
                      view
                        .symbolEffect(.bounce.down, value: item.animationTrigger)
                    }
                  })
                Text(item.title)
                  .font(.system(size: 12))
              }
            })
            .foregroundColor(state == item.tabBarType ? .blue : .gray)
            .padding(.vertical, 8)
            .padding(.horizontal, 5)
            
            if item.tabBarType != .profile {
              Spacer()
            }
          }
        }
        .padding(.horizontal, 40)
        .background(colorScheme == .light ? Color(UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 0.7)) : Color(uiColor: .systemGray6))
        .onReceive(orientationHasChanged) { orientation in
          isPortretOrientation = UIDevice.current.orientation.isPortrait
        }
      }
      .animation(.easeIn(duration: 0.2), value: state)
    }
  }
}

#Preview {
  RootView()
    .preferredColorScheme(.light)
}
