// 
//  PhotoViewerView.swift
//  LocalChat
//
//  Created by Егор Никитин on 10/7/24.
//

import SwiftUI

struct PhotoViewerView: View {
  
  @State var vm: PhotoViewerViewModel
  
  private var state: PhotoViewerState { vm }
  private var intent: PhotoViewerIntent { vm }
  
  var body: some View {
    NavigationStack {
      GeometryReader { proxy in
        ScrollView(.horizontal) {
          LazyHStack(spacing: .zero) {
            ForEach(state.assets) { asset in
              switch asset {
              case .photo(let photo, let image):
                PhotoAssetView(asset: photo, image: image)
                  .frame(
                    maxWidth: proxy.frame(in: .local).width,
                    maxHeight: proxy.frame(in: .local).height,
                    alignment: .center
                  )
              case .video(_):
                EmptyView()
              }
            }
          }
        }
        .scrollTargetBehavior(.paging)
        .onAppear(perform: intent.viewOnAppear)
        .modifier(PhotoViewerRouter(subjects: state.routerSubject, input: vm))
        .toolbar {
          ToolbarItem(placement: .topBarLeading) {
            Button {
              intent.reduce(.didTapClose)
            } label: {
              Text("Done")
            }
          }
        }
      }
    }
  }
}

#Preview {
  PhotoViewerAssembly().build(
    moduleOutput: nil,
    completion: nil
  )
}
