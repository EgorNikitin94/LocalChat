//
//  ConversationView.swift
//  LocalChat
//
//  Created by Egor Nikitin on 10/08/2023.
//  Copyright © 2023 Egor Nikitin. All rights reserved.
//

import SwiftUI
import Combine

struct ConversationView: View {
  
  @StateObject var container: MVIContainer<ConversationIntentProtocol, ConversationModelStateProtocol>
  
  private var intent: ConversationIntentProtocol { container.intent }
  private var model: ConversationModelStateProtocol { container.model }
  
  @State var showScrollToTopButton: Bool = false
  private let scrollProgressPublisher: PassthroughSubject<CGFloat, Never> = PassthroughSubject<CGFloat, Never>()
  
  @FocusState var isFocusedInput: Bool
  
  @Environment(\.colorScheme) private var colorScheme
  
  var body: some View {
    VStack(spacing: 0) {
      ScrollViewReader { scrollView in
        TrackableScrollView(
          .vertical,
          showIndicators: false,
          scrollProgressPublisher: scrollProgressPublisher
        ) {
          LazyVStack(alignment: .leading) {
            ForEach(model.realTimeMessages) { msg in
              MessageView(currentMessage: msg)
                .scaleEffect(x: 1, y: -1, anchor: .center)
                .id(msg.id)
            }
          }
          .padding(.vertical, 10)
        }
        .onReceive(scrollProgressPublisher, perform: { progress in
          if progress > 0.8 {
            print("Load Next Batch")
          }
          showScrollToTopButton = progress > 0.2 ? true : false
        })
        .onTapGesture {
          hideKeyboard()
        }
        .onChange(of: model.realTimeMessages, {  _, newValue in
          if let newViewModel = model.realTimeMessages.first, newViewModel.isFromCurrentUser {
            withAnimation(.spring()) {
              scrollView.scrollTo(newViewModel.id, anchor: .bottom)
            }
          }
        })

        .overlay(alignment: .topTrailing, content: {
          if showScrollToTopButton {
            Button {
              withAnimation(.spring()) {
                scrollView.scrollTo(model.realTimeMessages.first?.id, anchor: .bottom)
              }
            } label: {
              Image(systemName: "chevron.down.circle.fill")
                .resizable()
                .frame(width: 35, height: 35)
                .foregroundColor(.gray)
                .scaleEffect(x: 1, y: -1, anchor: .center)
                .background(content: {
                  Group {
                    if colorScheme == .dark {
                      Color.black
                    } else {
                      Color.white
                    }
                  }
                    .clipShape(Circle())
                })
                .padding(5)
            }
            .transition(.scale.combined(with: .opacity))
          }
        })
      }
      .animation(.spring(), value: showScrollToTopButton)
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
          .focused($isFocusedInput)
          .background(content: {
            if colorScheme == .light {
              Color.white
                .clipShape(.rect(cornerRadius: 20))
            } else {
              Color(uiColor: .systemGray4)
                .clipShape(.rect(cornerRadius: 20))
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
      .background(.ultraThinMaterial)
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
            .onTapGesture {
              intent.onTestIncomeMessageEvent()
            }
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

#Preview("Light") {
  var dialog: Dialog {
    let me = User(type: .selfUser, name: "Egor", passsword: "123", avatar: UIImage(named: "Me"), isOnline: true)
    let user3 = User(type: .anotherUser, name: "Sarra Bold", passsword: "1123", avatar: UIImage(named: "mock_2"), isOnline: false)
    return Dialog(user: user3, lastMessage: Message(from: user3, to: me, date: Date(timeIntervalSince1970: Date().timeIntervalSince1970 - 3600 * 4), text: "Sorry!"))
  }
  
  return NavigationStack {
    ConversationAssembly().build(peer: dialog.user, moduleOutput: nil, completion: nil)
  }
}

#Preview("Dark") {
  var dialog: Dialog {
    let me = User(type: .selfUser, name: "Egor", passsword: "123", avatar: UIImage(named: "Me"), isOnline: true)
    let user3 = User(type: .anotherUser, name: "Sarra Bold", passsword: "1123", avatar: UIImage(named: "mock_2"), isOnline: false)
    return Dialog(user: user3, lastMessage: Message(from: user3, to: me, date: Date(timeIntervalSince1970: Date().timeIntervalSince1970 - 3600 * 4), text: "Sorry!"))
  }
  
  return NavigationStack {
    ConversationAssembly().build(peer: dialog.user, moduleOutput: nil, completion: nil)
      .preferredColorScheme(.dark)
  }
}
