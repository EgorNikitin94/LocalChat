//
//  ProfileView.swift
//  LocalChat
//
//  Created by Egor Nikitin on 11/08/2023.
//  Copyright © 2023 Egor Nikitin. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
  
  @State var container: ModernMVIContainer<ProfileIntentProtocol, ProfileModelStateProtocol>
  
  private var intent: ProfileIntentProtocol { container.intent }
  private var model: ProfileModelStateProtocol { container.model }
  
  var body: some View {
    List {
      Section {
        Label("Notifications and sounds", systemImage: "app.badge.fill")
        Label("Storage", systemImage: "storefront.circle.fill")
        Label("Appearance", systemImage: "circle.lefthalf.filled.inverse")
        Label("Language", systemImage: "globe")
      } header: {
        VStack {
          Image(.me)
            .resizable()
            .scaledToFit()
            .clipShape(Circle())
            .squareSize(100)
          
          Text("Nikitin Egor")
            .font(.title)
        }
        .frame(maxWidth: .infinity)
        .padding()
      }
      
      Section {
        Label("About app", systemImage: "iphone.gen3")
        Label("Help", systemImage: "questionmark.circle.fill")
      }
      
      Section {
        Button {
          //
        } label: {
          Text("Logout")
            .foregroundStyle(.red)
            .frame(maxWidth: .infinity)
        }

      }
    }
    .onAppear(perform: intent.viewOnAppear)
    .modifier(ProfileRouter(subjects: model.routerSubject, intent: intent))
    .navigationTitle("Settings")
    .navigationBarTitleDisplayMode(.inline)
  }
}


#Preview("Light") {
  NavigationStack {
    ProfileAssembly().build(moduleOutput: nil, completion: nil)
  }
}

#Preview("Dark") {
  NavigationStack {
    ProfileAssembly().build(moduleOutput: nil, completion: nil)
      .preferredColorScheme(.dark)
  }
}
