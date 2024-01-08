//
//  RootView.swift
//  LocalChat
//
//  Created by Егор Никитин on 1/7/24.
//

import SwiftUI

struct RootView<Contacts: View, Dialogs: View, Settings: View>: View {
  
  @StateObject var container: MVIContainer<RootIntentProtocol, RootModelStateProtocol>
  
  private var intent: RootIntentProtocol { container.intent }
  private var model: RootModelStateProtocol { container.model }
  
  // Child submodules
  private(set) var contacts: Contacts
  private(set) var dialogsList: Dialogs
  private(set) var settings: Settings
  
  var body: some View {
    NavigationStack {
      VStack(spacing: .zero) {
        Group {
          switch model.state {
          case .contacts:
            contacts
              .navigationTitle("Contacts")
              .navigationBarTitleDisplayMode(.inline)
          case .chats:
            dialogsList
          case .profile:
            settings
          }
        }
        .frame(maxHeight: .infinity)
        
        CustomTabBar(
          tabBarItems: model.tabBarItems,
          state: $container.model.state) { type in
            intent.didTapOnTabBarItem(with: type)
          }
      }
      .animation(.easeIn(duration: 0.2), value: model.state)
    }
    .onAppear(perform: intent.viewOnAppear)
    .modifier(RootRouter(subjects: model.routerSubject, intent: intent))
  }
}

struct CustomTabBar: View {
  @State var tabBarItems: [RootViewTabItem]
  @Binding var state: RootViewTabItem.TabBarItemType
  var completion: (RootViewTabItem.TabBarItemType) -> Void
  
  @State private var isPortretOrientation: Bool = true
  private let orientationHasChanged = NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)
  
  @Environment(\.colorScheme) private var colorScheme
  
  var body: some View {
    HStack(alignment: .top) {
      ForEach(tabBarItems) { item in
        Button(action: {
          completion(item.tabBarType)
        }, label: {
          let Layout = isPortretOrientation ? AnyLayout(VStackLayout()) : AnyLayout(HStackLayout())
          Layout {
            Image(systemName: item.imageName)
              .resizable()
              .frame(width: 21, height: 21)
              .symbolEffect(.bounce.down, value: item.animationTrigger)
            
            Text(item.title)
              .font(.system(size: 12))
          }
          .padding(.vertical, 8)
          .padding(.horizontal, 5)
          .frame(maxWidth: .infinity)
        })
        .foregroundColor(state == item.tabBarType ? .blue : .gray)
      }
    }
    .padding(.horizontal, 20)
    .background(colorScheme == .light ? Color(UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 0.7)) : Color(uiColor: .systemGray6))
    .onReceive(orientationHasChanged, perform: { _ in
      isPortretOrientation = UIDevice.current.orientation.isPortrait
    })
  }
}

#Preview("Light") {
  RootAssembly().build(
    moduleOutput: nil,
    completion: nil
  )
  .preferredColorScheme(.light)
}

#Preview("Dark") {
  RootAssembly().build(
    moduleOutput: nil,
    completion: nil
  )
  .preferredColorScheme(.dark)
}
