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
  
  var body: some View {
    Text("Hallo amo module")
      .onAppear(perform: intent.viewOnAppear)
      .modifier(MediaPickerRouter(subjects: model.routerSubject, intent: intent))
  }
}

struct MediaPickerView_Previews: PreviewProvider {
  static var previews: some View {
    MediaPickerAssembly().build(moduleOutput: nil, completion: nil)
  }
}
