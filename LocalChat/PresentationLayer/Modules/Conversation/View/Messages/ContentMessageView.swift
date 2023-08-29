//
//  ContentMessageView.swift
//  LocalChat
//
//  Created by Егор Никитин on 10/12/22.
//

import SwiftUI

struct ContentMessageView: View {
  @StateObject var currentMessage: MessageDisplayItem
  
  @Environment(\.colorScheme) private var colorScheme
  
  var body: some View {
    ChatBubble(direction: currentMessage.isFromCurrentUser ? .right : .left,
               isEndOfSequence: currentMessage.isEndOfSequence) {
      switch currentMessage.messageContentType {
      case .text:
        VStack(alignment: .trailing, spacing: 4) {
          Text(currentMessage.textContent)
            .font(.system(size: 16))
          
          Text(currentMessage.dateText)
            .foregroundColor(currentMessage.isFromCurrentUser ? Color.white : colorScheme == .light ? Color.gray : .white)
            .font(.system(size: 10))
        }
        .foregroundColor(currentMessage.isFromCurrentUser ? Color.white : colorScheme == .light ? Color.black : .white)
        .padding(10)
        .background(currentMessage.isFromCurrentUser ? Color.blue : colorScheme == .light ? Color(UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)) : Color(uiColor: .systemGray3))
      case .image:
        ZStack(alignment: .bottomTrailing) {
          Image(uiImage: currentMessage.media!)
            .resizable()
            .frame(maxWidth: 300, maxHeight: 400)
            .cornerRadius(14)
            .padding(5)
          
          Text(currentMessage.dateText)
            .foregroundColor(currentMessage.isFromCurrentUser ? Color.white : colorScheme == .light ? Color.gray : .white)
            .font(.system(size: 10))
            .padding(.horizontal, 6)
            .padding(.vertical, 3)
            .background {
              Color(uiColor: .systemGray6)
            }
            .cornerRadius(17)
            .padding(10)
        }
          .padding(.trailing, currentMessage.isEndOfSequence ? 4 : 0)
          .background(currentMessage.isFromCurrentUser ? Color.blue : colorScheme == .light ? Color(UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)) : Color(uiColor: .systemGray3))
      }
    }
  }
}

struct ContentMessageView_Previews: PreviewProvider {
  static let me = User(type: .selfUser, name: "Mike", passsword: "123", avatar: nil, isOnline: true)
  static let user3 = User(type: .anotherUser, name: "Sarra Bold", passsword: "1123", avatar: UIImage(named: "mock_2"), isOnline: false)
  static let message  = Message(from: user3, to: me, date: Date(timeIntervalSince1970: Date().timeIntervalSince1970 - 3600 * 4), text: "There are a lot of premium iOS templates on iosapptemplates.com")
  static var previews: some View {
    ContentMessageView(currentMessage: MessageDisplayItem(with: message))
  }
}
