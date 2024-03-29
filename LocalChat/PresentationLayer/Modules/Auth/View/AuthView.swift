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
  
  @FocusState private var focusedTextField: AuthModel.FocusedField?
  
  @Environment(AppState.self) private var appState: AppState
  
  var body: some View {
    VStack(spacing: 20) {
      Image(.logo)
        .resizable()
        .squareSize(70)
        .cornerRadius(10)
        .onTapGesture {
          focusedTextField = nil
        }
      Text("Welcome!")
        .multilineTextAlignment(.center)
        .font(.largeTitle)
        .bold()
      VStack(spacing: 10) {
        TextField(
          "Enter your phone",
          value: $container.model.login,
          formatter: AuthModel.PhoneFormatter()
        )
          .authTextFieldStyle()
          .keyboardType(.numberPad)
          .focused($focusedTextField, equals: .phone)
          .onChange(of: model.login) { _, newValue in
            intent.didChangeLogin(with: newValue)
          }
        
        if model.state.rawValue > AuthModel.State.none.rawValue {
          SecureField("Enter your code", text: $container.model.password)
            .authTextFieldStyle()
            .keyboardType(.numberPad)
            .focused($focusedTextField, equals: .code)
            .onChange(of: model.password) { _, newValue in
              intent.didChangePassword(with: newValue)
            }
            .transition(.move(edge: .bottom).combined(with: .opacity))
        }
        
        if model.state.rawValue > AuthModel.State.passwordFieldEnabled.rawValue {
          Button {
            //intent.didTapSignIn()
            appState.loggin = true
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
        }
      }
      .onTapGesture {}
    }
    .frame(maxWidth: 400)
    .animation(.bouncy, value: model.state)
    .padding(.horizontal, 40)
    .onAppear { self.focusedTextField = model.focusedTextField }
    .onChange(of: focusedTextField ?? .none, { _, newValue in
      container.model.focusedTextField = newValue
    })
    .onChange(of: model.focusedTextField, { _, newValue in
      focusedTextField = newValue
    })
    .contentShape(Rectangle())
    .onTapGesture {
      focusedTextField = nil
    }
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
