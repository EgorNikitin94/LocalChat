//
//  ConversationView.swift
//  LocalChat
//
//  Created by Egor Nikitin on 10/08/2023.
//  Copyright © 2023 Egor Nikitin. All rights reserved.
//

import SwiftUI

struct ConversationView: View {
  
  @StateObject var container: MVIContainer<ConversationIntentProtocol, ConversationModelStateProtocol>
  
  private var intent: ConversationIntentProtocol { container.intent }
  private var model: ConversationModelStateProtocol { container.model }
  
  @Environment(\.colorScheme) private var colorScheme
  
  var body: some View {
    VStack(spacing: 0) {
      ScrollView(.vertical, showsIndicators: false) {
        LazyVStack(alignment: .leading) {
          ForEach(model.realTimeMessages) { msg in
            MessageView(currentMessage: msg)
              .scaleEffect(x: 1, y: -1, anchor: .center)
          }
        }
        .padding(.vertical, 10)
      }
      .onTapGesture {
        hideKeyboard()
      }
//      .overlay(alignment: .topTrailing ,content: {
//        Button {
//          //
//        } label: {
//          Image(systemName: "arrowtriangle.down.circle.fill")
//            .resizable()
//            .frame(width: 30, height: 30)
//            .scaleEffect(x: 1, y: -1, anchor: .center)
//            .padding()
//        }
//
//      })
      .scaleEffect(x: 1, y: -1, anchor: .center)
      .animation(model.isInitialState ? nil : .spring(), value: model.realTimeMessages)
      Divider()
        .background(content: {
          Color.gray
        })
      
      HStack(alignment: .bottom) {
        Button {
          intent.openMediaPicker()
        } label: {
          Image(systemName: "paperclip.circle.fill")
            .resizable()
        }
        .frame(width: 30, height: 30)
        
        TextField("Write a message...", text: $container.model.inputText, axis: .vertical)
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
        
        if !model.hideSendButton {
          Button {
            intent.sendMessage(with: model.inputText)
          } label: {
            Image(systemName: "arrow.up.circle.fill")
              .resizable()
          }
          .transition(AnyTransition.scale.combined(with: .opacity))
          .frame(width: 30, height: 30)
        }
      }
      .animation(.easeIn(duration: 0.2), value: model.hideSendButton)
      .padding(.top)
      .frame(minHeight: CGFloat(50))
      .padding([.bottom, .leading, .trailing])
      .background(colorScheme == .light ? Color(UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 0.7)) : Color(uiColor: .systemGray6))
    }
    .navigationBarTitleDisplayMode(.inline)
    .toolbar(content: {
      ToolbarItem(placement: .principal) {
        VStack(spacing: 0) {
          Text(model.navTitle)
          if model.isOnline {
            HStack(spacing: 5) {
              Text("online")
                .font(.system(size: 14))
              
              Circle()
                .foregroundColor(.green)
                .frame(width: 7, height: 7)
            }
            .padding(3)
          } else {
            Text(model.onlineDate)
              .font(.system(size: 14))
              .foregroundColor(.gray)
          }
        }
      }
      ToolbarItem(placement: .navigationBarTrailing) {
        if let di = model.avatarDisplayItem {
          AvatarView(displayItem: di, needShowOnline: false)
            .frame(width: 35, height: 35)
        }
      }
    })
    .onAppear(perform: intent.viewOnAppear)
    .modifier(ConversationRouter(subjects: model.routerSubject, intent: intent))
    .background(content: {
      if colorScheme == .light {
        Image("ChatBackgroundWhite")
          .resizable()
          .scaledToFill()
          .ignoresSafeArea()
      } else {
        Image("ChatBackgroundBlack")
          .resizable()
          .scaledToFill()
          .ignoresSafeArea()
      }
    })
    
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
      ConversationAssembly().build(peer: dialog.user, moduleOutput: nil, completion: nil)
        .preferredColorScheme(.light)
    }
  }
}
