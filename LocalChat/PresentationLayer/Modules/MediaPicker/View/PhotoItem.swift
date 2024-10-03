//
//  PhotoItem.swift
//  LocalChat
//
//  Created by Егор Никитин on 10/3/24.
//

import SwiftUI

struct PhotoItem: View {
  @State var item: PhotoDisplayItem
  @State private var image: UIImage = UIImage(systemName: "photo.fill")!
  var intent: MediaPickerIntentProtocol
  @Namespace private var namespace
  
  var body: some View {
    ZStack(alignment: .topTrailing) {
      Image(uiImage: image)
        .resizable()
        .frame(height: 100)
        .cornerRadius(5)
        .transition(.opacity)
        .onTapGesture {
          intent.didTapOn(item, namespace: namespace)
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
    .task {
      guard item.image == nil else { return }
      let image = try? await item.asset
        .requestImage(
          with: CGSize(
            width: 200,
            height: 200
          )
        )
      if let image {
        withAnimation(.easeIn) {
          item.image = image
          self.image = image
        }
      }
    }
    .matchedTransitionSource(id: item.id, in: namespace)
  }
}

struct ScaleButtonStyle: ButtonStyle {
  func makeBody(configuration: Self.Configuration) -> some View {
    configuration.label
      .scaleEffect(configuration.isPressed ? 1.5 : 1)
  }
}

