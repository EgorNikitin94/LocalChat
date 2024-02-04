//
//  AuthView.swift
//  LocalChat
//
//  Created by Egor Nikitin on 11/08/2023.
//  Copyright © 2023 Egor Nikitin. All rights reserved.
//

import SwiftUI

struct AuthView: View {
  
  @State var container: ModernMVIContainer<AuthIntentProtocol, AuthModelStateProtocol>
  
  private var intent: AuthIntentProtocol { container.intent }
  private var model: AuthModelStateProtocol { container.model }
  
  var body: some View {
    VStack(spacing: 20) {
      Image(.logo)
        .resizable()
        .frame(width: 70, height: 70)
        .cornerRadius(10)
      Text("Welcome!")
        .font(.largeTitle)
        .bold()
      VStack(spacing: 10) {
        TextField("Enter your login", text: $container.model.login)
          .authTextFieldStyle()
        
        if model.passwordFieldEnabled {
          SecureField("Enter your password", text: $container.model.password)
            .authTextFieldStyle()
            .transition(.move(edge: .bottom).combined(with: .opacity))
        }
        
        if model.buttonEnabled {
          Button {
            intent.didTapSignIn()
          } label: {
            Text("Sign In")
              .font(.title3)
              .bold()
              .frame(maxWidth: .infinity)
              .foregroundColor(.white)
              .padding(.horizontal, 80)
              .padding(.vertical)
              .background(
                LinearGradient(
                  colors: [
                    .blue.opacity(0.4),
                    .purple
                  ],
                  startPoint: .bottomLeading,
                  endPoint: .topTrailing
                )
              )
              .cornerRadius(10)
          }
          .transition(.move(edge: .bottom).combined(with: .opacity))
          .disabled(!model.buttonEnabled)
        }
      }
    }
    .frame(maxWidth: 400)
    .animation(.bouncy, value: model.passwordFieldEnabled)
    .animation(.bouncy, value: model.buttonEnabled)
    .padding(.horizontal, 40)
    .onAppear(perform: intent.viewOnAppear)
    .modifier(AuthRouter(subjects: model.routerSubject, intent: intent))
  }
}

fileprivate struct AuthTextFieldStyle: ViewModifier {
  @Environment(\.colorScheme) private var colorScheme
  
  func body(content: Content) -> some View {
    content
      .padding()
      .background(
        Color.gray
          .opacity(colorScheme == .light ? 0.1 : 0.2)
          .clipShape(
            RoundedRectangle(
              cornerRadius: 10
            )
          )
      )
  }
}

fileprivate extension View {
  func authTextFieldStyle() -> some View {
    self.modifier(AuthTextFieldStyle())
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
