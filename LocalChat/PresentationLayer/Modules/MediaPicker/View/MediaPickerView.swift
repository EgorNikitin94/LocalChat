//
//  MediaPickerView.swift
//  LocalChat
//
//  Created by Egor Nikitin on 13/08/2023.
//  Copyright © 2023 Egor Nikitin. All rights reserved.
//

import SwiftUI

struct MediaPickerView: View {
  
  @StateObject var container: MVIContainer<MediaPickerIntentProtocol, MediaPickerModelStateProtocol>
  
  private var intent: MediaPickerIntentProtocol { container.intent }
  private var model: MediaPickerModelStateProtocol { container.model }
  
  private let columns = [
    GridItem(.adaptive(minimum: 100))
  ]
  
  var body: some View {
    NavigationStack {
      TabView {
        ScrollView {
          LazyVGrid(columns: columns, spacing: 5) {
            ForEach(model.imagesDisplayItems, id: \.self) { item in
              Image(uiImage: item.image)
                .resizable()
                .frame(height: 100)
                .onTapGesture {
                  //
                }
            }
          }
          .padding(5)
        }
        .tabItem {
          Image(systemName: "photo.stack")
          Text("Фото")
        }
        
        Text("")
          .tabItem {
            Image(systemName: "folder")
            Text("Файлы")
          }
      }
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
          Button {
            intent.closeModule()
          } label: {
            Text("закрыть")
          }
        }
      }
      .onAppear(perform: intent.viewOnAppear)
      .modifier(MediaPickerRouter(subjects: model.routerSubject, intent: intent))
    }
  }
}

struct MediaPickerView_Previews: PreviewProvider {
  static var previews: some View {
    MediaPickerAssembly().build(moduleOutput: nil, completion: nil)
  }
}
