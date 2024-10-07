// 
//  PhotoViewerView.swift
//  LocalChat
//
//  Created by Егор Никитин on 10/7/24.
//

import SwiftUI

struct PhotoViewerView: View {
  
  @State var container: ModernMVIContainer<PhotoViewerIntentProtocol, PhotoViewerModelStateProtocol>
  
  private var intent: PhotoViewerIntentProtocol { container.intent }
  private var model: PhotoViewerModelStateProtocol { container.model }
  
  var body: some View {
    Text("Hallo amo module")
      .onAppear(perform: intent.viewOnAppear)
      .modifier(PhotoViewerRouter(subjects: model.routerSubject, intent: intent))
  }
}

#Preview {
  PhotoViewerAssembly().build(
    moduleOutput: nil,
    completion: nil
  )
}
