//
//  RootView.swift
//  LocalChat
//
//  Created by Егор Никитин on 10/12/22.
//

import SwiftUI

enum RootViewState {
  case autorize, dialogs
}

struct RootView: View {
  
  @State private var rootView : RootViewState = .autorize
  
  var body: some View {
    NavigationView {
      switch rootView {
      case .autorize:
        LogInView(rootView: $rootView)
      case .dialogs:
        DialogsListView(rootView: $rootView)
      }
    }.navigationViewStyle(StackNavigationViewStyle())
  }
}

struct RootView_Previews: PreviewProvider {
  static var previews: some View {
    RootView()
  }
}
