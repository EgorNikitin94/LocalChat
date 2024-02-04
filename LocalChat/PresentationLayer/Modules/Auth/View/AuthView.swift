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
  
  @State var login: String = ""
  @State var password: String = ""
  
  var body: some View {
    VStack(spacing: 20) {
      Text("Welcome!")
        .font(.largeTitle)
        .bold()
      VStack(spacing: 10) {
        TextField("Enter your login", text: $login)
          .padding()
          .background(
            Color.gray
              .opacity(0.1)
              .clipShape(
                RoundedRectangle(
                  cornerRadius: 10
                )
              )
          )
        
        SecureField("Enter your password", text: $password)
          .padding()
          .background(
            Color.gray
              .opacity(0.1)
              .clipShape(
                RoundedRectangle(
                  cornerRadius: 10
                )
              )
          )
        
        Button {
          //
        } label: {
          Text("Sigh In")
            .font(.title3)
            .bold()
            .frame(maxWidth: .infinity)
            .foregroundColor(.white)
            .padding(.horizontal, 80)
            .padding(.vertical)
            .background(LinearGradient(colors: [.blue.opacity(0.4), .purple], startPoint: .bottomLeading, endPoint: .topTrailing))
            .cornerRadius(10)
        }
        
      }
    }
    .padding(.horizontal, 40)
    .onAppear(perform: intent.viewOnAppear)
    .modifier(AuthRouter(subjects: model.routerSubject, intent: intent))
  }
}

#Preview("Light") {
  AuthAssembly().build(moduleOutput: nil, completion: nil)
  .preferredColorScheme(.light)
}

#Preview("Dark") {
  AuthAssembly().build(moduleOutput: nil, completion: nil)
  .preferredColorScheme(.dark)
}
