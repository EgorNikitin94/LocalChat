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
      ForEach(model.sections) { section in
        Section {
          ForEach(section.items, id: \.self) { item in
            switch item {
            case .base(let title, let imageName, let imageColor):
              Button(action: {
                //
              }, label: {
                LabeledContent {
                  Image(systemName: "chevron.right")
                } label: {
                  Label(
                    title: {
                      Text(title)
                        .foregroundStyle(Color.primary)
                    }, icon: {
                      Image(systemName: imageName)
                        .foregroundStyle(imageColor)
                    }
                  )
                }
              })
            case .button(let title):
              Button {
                //
              } label: {
                Text(title)
                  .foregroundStyle(.red)
                  .frame(maxWidth: .infinity)
              }
            }
          }
        } header: {
          switch section.section {
          case .none:
            EmptyView()
          case .userInfo(let avatar, let name, let phone):
            VStack {
              Image(uiImage: avatar)
                .resizable()
                .scaledToFit()
                .clipShape(Circle())
                .squareSize(100)
              
              Text(name)
                .font(.title)
              
              Text(phone)
                .font(.subheadline)
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom)
          }
        }
        
      }
    }
    .onAppear(perform: intent.viewOnAppear)
    .modifier(ProfileRouter(subjects: model.routerSubject, intent: intent))
    //    .navigationTitle("Settings")
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
