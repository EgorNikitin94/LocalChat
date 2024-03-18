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
        Button(action: {
          //
        }, label: {
          LabeledContent {
            Image(systemName: "chevron.right")
          } label: {
            Label(
              title: { Text("Notifications and sounds").foregroundStyle(.white) },
              icon: { Image(systemName: "app.badge.fill").foregroundStyle(.red) }
            )
          }
        })
        Label("Storage and memory", systemImage: "storefront.circle.fill")
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
          
          Text("8 (999) 999-99-99")
            .font(.subheadline)
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
