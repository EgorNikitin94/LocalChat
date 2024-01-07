//
//  RootView.swift
//  LocalChat
//
//  Created by Егор Никитин on 1/7/24.
//

import SwiftUI

struct RootView: View {
  
  @StateObject var container: MVIContainer<RootIntentProtocol, RootModelStateProtocol>
  
  private var intent: RootIntentProtocol { container.intent }
  private var model: RootModelStateProtocol { container.model }
  
  var body: some View {
    NavigationStack {
      VStack(spacing: .zero) {
        switch model.state {
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
  
  @State private var isPortretOrientation: Bool = UIDevice.current.orientation.isPortrait
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
