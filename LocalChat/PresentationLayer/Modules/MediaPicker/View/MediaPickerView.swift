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
            ForEach(model.imagesDisplayItems) { item in
              PhotoItem(item: item, intent: intent)
            }
          }
          .padding(5)
        }
        .tabItem {
          Image(systemName: "photo.stack")
          Text("Галерея")
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

struct ScaleButtonStyle: ButtonStyle {
  func makeBody(configuration: Self.Configuration) -> some View {
    configuration.label
      .scaleEffect(configuration.isPressed ? 1.5 : 1)
  }
}

struct PhotoItem: View {
  @StateObject var item: PhotoDisplayItem
  var intent: MediaPickerIntentProtocol
  
  var body: some View {
    ZStack(alignment: .topTrailing) {
      Image(uiImage: item.image)
        .resizable()
        .frame(height: 100)
        .cornerRadius(5)
        .onTapGesture {
          //
        }
      
      Button {
        intent.didSelectItem(item)
      } label: {
        ZStack {
          if item.selected {
            Color.blue
              .transition(.scale)
              .cornerRadius(10)
          } else {
            Color.clear
              .transition(.scale)
              .cornerRadius(10)
          }
          
          Text(item.number ?? "")
            .font(.system(size: 14))
            .foregroundColor(.white)
            .padding(3)
          
          Circle().stroke(Color.white, lineWidth: 2.5)
            .shadow(color: .black, radius: 10, x: -5, y: 5)
        }
          .frame(width: 20, height: 20)
          .padding(5)
      }//.buttonStyle(ScaleButtonStyle())
      .animation(Animation.spring(), value: item.selected)

    }
  }
}

struct MediaPickerView_Previews: PreviewProvider {
  static var previews: some View {
    MediaPickerAssembly().build(moduleOutput: nil, completion: nil)
  }
}
