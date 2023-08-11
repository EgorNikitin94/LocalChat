//
//  AuthView.swift
//  LocalChat
//
//  Created by Egor Nikitin on 11/08/2023.
//  Copyright © 2023 Egor Nikitin. All rights reserved.
//

import SwiftUI

struct AuthView: View {
  
  @StateObject var container: MVIContainer<AuthIntentProtocol, AuthModelStateProtocol>
  
  private var intent: AuthIntentProtocol { container.intent }
  private var model: AuthModelStateProtocol { container.model }
  
  var body: some View {
    Text("Hallo amo module")
      .onAppear(perform: intent.viewOnAppear)
      .modifier(AuthRouter(subjects: model.routerSubject, intent: intent))
  }
}

struct AuthView_Previews: PreviewProvider {
  static var previews: some View {
    AuthAssembly().build(moduleOutput: nil, completion: nil)
  }
}
