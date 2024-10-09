//
//  PhotoViewer.swift
//  LocalChat
//
//  Created by Егор Никитин on 10/3/24.
//

import SwiftUI

struct PhotoAssetView: View {
  @State var asset: PHPhotoAsset
  @State var image: UIImage?
  @State private var scale: CGFloat = 1.0
  @State private var offset: CGSize = .zero
  
  var body: some View {
    Group {
      if let image {
        Image(uiImage: image)
          .resizable()
          .aspectRatio(contentMode: .fit)
          .scaleEffect(scale)
          .offset(offset)
          .transition(.opacity)
          .onTapGesture(count: 2) {
            withAnimation {
              self.scale = 1.0
              self.offset = .zero
            }
          }
          .gesture(
            DragGesture()
              .onChanged({ value in
                if scale != 1.0 {
                  self.offset = value.translation
                }
              })
          )
          .gesture(
            MagnificationGesture()
              .onChanged { value in
                self.scale = value.magnitude
              }
          )
          .task {
            let image = try? await asset
              .requestImage(
                with: CGSize(
                  width: asset.originalSize.width,
                  height: asset.originalSize.height
                )
              )
            if let image {
              withAnimation(.easeIn) {
                self.image = image
              }
            }
          }
      } else {
        ProgressView()
      }
    }
    .toolbar {
      ToolbarItem(placement: .automatic) {
        Text(asset.name)
          .font(.caption)
          .frame(maxWidth: 300)
          .lineLimit(1)
      }
    }
  }
}
