//
//  ProfileView.swift
//  LocalChat
//
//  Created by Egor Nikitin on 11/08/2023.
//  Copyright © 2023 Egor Nikitin. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
  
  @StateObject var container: MVIContainer<ProfileIntentProtocol, ProfileModelStateProtocol>
  
  private var intent: ProfileIntentProtocol { container.intent }
  private var model: ProfileModelStateProtocol { container.model }
  
  var body: some View {
    Text("Hallo amo module")
      .onAppear(perform: intent.viewOnAppear)
      .modifier(ProfileRouter(subjects: model.routerSubject, intent: intent))
  }
}

struct ProfileView_Previews: PreviewProvider {
  static var previews: some View {
    ProfileAssembly().build(moduleOutput: nil, completion: nil)
  }
}
