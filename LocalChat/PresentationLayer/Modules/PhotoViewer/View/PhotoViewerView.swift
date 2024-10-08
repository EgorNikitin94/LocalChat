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
      ScrollView {
        LazyHStack(spacing: .zero) {
          ForEach(state.assets) { asset in
            switch asset {
            case .photo(let photo):
              PhotoAssetView(asset: photo, image: UIImage())
            case .video(let video):
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
            //
          } label: {
            Text("Done")
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
