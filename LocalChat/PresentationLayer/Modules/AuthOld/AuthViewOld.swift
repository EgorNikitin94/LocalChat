////
////  LogInView.swift
////  LocalChat
////
////  Created by Егор Никитин on 10/7/22.
////
//
//import SwiftUI
//
//struct AuthView: View {
//  
//  @ObservedObject var viewModel: AuthViewModel
//  
//  var body: some View {
//    NavigationStack {
//      VStack(spacing: 25) {
//        HStack {
//          Text("LocalChat")
//            .font(.title)
//            .fontWeight(.heavy)
//          Image(systemName: "message.fill")
//        }
//        ZStack {
//          TextField("user name", text: $viewModel.name)
//            .padding(.horizontal)
//          RoundedRectangle(cornerRadius: 10).stroke(Color.secondary.opacity(1), lineWidth: 1.5)
//        }
//        .frame(height: 44)
//        ZStack {
//          SecureField("password", text: $viewModel.password)
//            .padding(.horizontal)
//          RoundedRectangle(cornerRadius: 10).stroke(Color.secondary.opacity(1), lineWidth: 1.5)
//        }
//        .frame(height: 44)
//        .isHidden(viewModel.hidePasswordInput)
//        .animation(.easeIn, value: viewModel.hidePasswordInput)
//        .transition(.slide)
//        Button {
//          //
//        } label: {
//          Text("Sigh In")
//            .foregroundColor(.white)
//            .padding(.horizontal, 80)
//            .padding(.vertical)
//            .background( Color.blue)
//            .cornerRadius(10)
//        }
//        .isHidden(viewModel.bottonDisabled)
//        .animation(.easeIn, value: viewModel.bottonDisabled)
//        .transition(.slide)
//        
//      }
//      .onTapGesture {
//        hideKeyboard()
//      }
//      .padding(.horizontal)
//    }
//  }
//}
//
//struct LogInView_Previews: PreviewProvider {
//  static var previews: some View {
//    moduleAssembly.assemblyAuth()
//  }
//}
