//
//  ConversationView.swift
//  LocalChat
//
//  Created by Егор Никитин on 10/12/22.
//

import SwiftUI

struct ConversationView: View {
  @ObservedObject var viewModel: ConversationViewModel
  
  @Environment(\.colorScheme) private var colorScheme
  
  var body: some View {
    VStack(spacing: 0) {
      List {
        ForEach(viewModel.realTimeMessages.reversed()) { msg in
          MessageView(currentMessage: msg)
            .listRowSeparator(.hidden)
            .scaleEffect(x: 1, y: -1, anchor: .center)
        }
      }
      .onTapGesture {
        hideKeyboard()
      }
      .scaleEffect(x: 1, y: -1, anchor: .center)
      .listStyle(.plain)
      //.padding(.vertical)
      
      Divider()
        .background(content: {
          Color.gray
        })
      
      HStack(alignment: .bottom) {
        TextField("Write a message...", text: $viewModel.inputText, axis: .vertical)
          .padding(.horizontal)
          .frame(minHeight: CGFloat(30))
          .lineLimit(12)
          .background(content: {
            if colorScheme == .light {
              Color.white
                .cornerRadius(20)
            } else {
              Color(uiColor: .systemGray4)
                .cornerRadius(20)
            }
          })
          .overlay {
            RoundedRectangle(cornerRadius: 20)
              .stroke(Color(uiColor: .systemGray2), lineWidth: 1)
          }
          .animation(.easeIn(duration: 0.2), value: viewModel.hideSendButton)
        
        if !viewModel.hideSendButton {
            Button {
              withAnimation {
                viewModel.sendMessage()
              }
            } label: {
              Image(systemName: "arrow.up.circle.fill")
                .resizable()
                .transition(.move(edge: .trailing).animation(.easeIn))
                .animation(.easeIn(duration: 0.2), value: viewModel.hideSendButton)
            }
            .frame(width: 30, height: 30)
        }
      }
      .padding(.top)
      .frame(minHeight: CGFloat(50))
      .padding([.bottom, .leading, .trailing])
      .background(colorScheme == .light ? Color(UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 0.7)) : Color(uiColor: .systemGray6))
    }
    .navigationTitle(viewModel.dialog.user.name)
    .navigationBarTitleDisplayMode(.inline)
  }
}

struct ConversationView_Previews: PreviewProvider {
  
  static var dialog: Dialog {
    let me = User(type: .selfUser, name: "Egor", passsword: "123", avatar: UIImage(named: "Me"), isOnline: true)
    let user3 = User(type: .anotherUser, name: "Sarra Bold", passsword: "1123", avatar: UIImage(named: "mock_2"), isOnline: false)
    return Dialog(user: user3, lastMessage: Message(from: user3, to: me, date: Date(timeIntervalSince1970: Date().timeIntervalSince1970 - 3600 * 4), text: "Sorry!"))
  }
  
  static var previews: some View {
    NavigationStack {
      moduleAssembly.assemblyConversation(for: dialog)
    }
  }
}
