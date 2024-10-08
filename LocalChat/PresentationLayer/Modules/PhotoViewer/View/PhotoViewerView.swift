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
    Text("Hallo amo module")
      .onAppear(perform: intent.viewOnAppear)
      .modifier(PhotoViewerRouter(subjects: state.routerSubject, input: vm))
  }
}

#Preview {
  PhotoViewerAssembly().build(
    moduleOutput: nil,
    completion: nil
  )
}
