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

struct PhotoViewer: View {
  @State var image: UIImage
  @State private var scale: CGFloat = 1.0
  @State private var offset: CGSize = .zero
  @Environment(\.presentationMode) private var presentationMode
  
  var body: some View {
    NavigationStack {
      Image(uiImage: image)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .scaleEffect(scale)
        .offset(offset)
        .onTapGesture(count: 2) {
          withAnimation {
            self.scale = 1.0
            self.offset = .zero
          }
        }
        .gesture(
          DragGesture()
            .onChanged({ value in
              self.offset = value.translation
            })
        )
        .gesture(
          MagnificationGesture()
            .onChanged { value in
              self.scale = value.magnitude
            }
        )
      
        .toolbar {
          ToolbarItem(placement: .navigationBarLeading) {
            Button {
              presentationMode.wrappedValue.dismiss()
            } label: {
              Text("Done")
            }
          }
        }
    }
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
//        .matchedGeometryEffect(id: "1", in: namespace)
        .onTapGesture {
          intent.didTapOn(item)
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
        .animation(Animation.spring(), value: item.selected)
      }//.buttonStyle(ScaleButtonStyle())
      
    }
  }
}

#Preview {
  MediaPickerAssembly().build(moduleOutput: nil, completion: nil)
    .preferredColorScheme(.dark)
}
