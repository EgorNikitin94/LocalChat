//
//  MediaPickerView.swift
//  LocalChat
//
//  Created by Egor Nikitin on 13/08/2023.
//  Copyright © 2023 Egor Nikitin. All rights reserved.
//

import SwiftUI

struct MediaPickerView: View {
  
  @State var container: ModernMVIContainer<MediaPickerIntentProtocol, MediaPickerModelStateProtocol>
  
  private var intent: MediaPickerIntentProtocol { container.intent }
  private var model: MediaPickerModelStateProtocol { container.model }
  
  private let columns = [
    GridItem(.adaptive(minimum: 100))
  ]
  
  var body: some View {
    NavigationStack {
      VStack {
        ScrollView {
          LazyVGrid(columns: columns, spacing: 5) {
            ForEach(model.imagesDisplayItems) { item in
              PhotoItem(item: item, intent: intent)
            }
          }
          .padding(5)
        }
        
        Group {
          if model.selectedItemsCount > 0 {
            Button {
              intent.sendSelectedMedia()
            } label: {
              Text("Send: \(model.selectedItemsCount)")
            }
            .buttonStyle(.bordered)
          } else {
            ScrollView(.horizontal) {
              HStack(spacing: 10) {
                ForEach(model.buttons) { button in
                  Button {
                    intent.didTapOn(buttonType: button.type)
                  } label: {
                    HStack {
                      Image(systemName: button.imageName)
                      Text(button.title)
                    }
                  }
                  .buttonStyle(.bordered)
                }
              }
              .padding(.horizontal)
            }
          }
        }
        .transition(.move(edge: .bottom).combined(with: .opacity))
        .padding(.vertical, 10)
      }
      .animation(.easeIn, value: model.selectedItemsCount > 0)
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
          Button {
            intent.closeModule()
          } label: {
            Text("Close")
          }
        }
      }
      .onAppear(perform: intent.viewOnAppear)
      .modifier(MediaPickerRouter(subjects: model.routerSubject, intent: intent))
    }
  }
}

#Preview {
  MediaPickerAssembly().build(moduleOutput: nil, completion: nil)
    .preferredColorScheme(.dark)
}
