//
//  MessageView.swift
//  LocalChat
//
//  Created by Егор Никитин on 10/12/22.
//

import SwiftUI

struct MessageView: View {
  var currentMessage: Message
  @Environment(\.colorScheme) private var colorScheme
  
  var body: some View {
    HStack(alignment: .bottom, spacing: 15) {
      if !currentMessage.from.isCurrentUser {
        if let avatar = currentMessage.from.avatar {
          Image(uiImage: avatar)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 40, height: 40)
            .clipShape(Circle())
        } else {
          ZStack {
            Color(.lightGray)
              .clipShape(Circle())
              .frame(width: 40, height: 40)
            Text("\(currentMessage.from.name.first?.description ?? "")")
              .foregroundColor(colorScheme == .light ? .white : .black)
              .font(.title)
              .bold()
          }
        }
      } else {
        Spacer()
      }
      ContentMessageView(contentMessage: currentMessage.text,
                         isCurrentUser: currentMessage.from.isCurrentUser,
                         date: currentMessage.date)
    }
  }
}

struct MessageView_Previews: PreviewProvider {
  static let me = User(type: .selfUser, name: "Mike", passsword: "123", avatar: nil, isOnline: true)
  static let user3 = User(type: .anotherUser, name: "Sarra Bold", passsword: "1123", avatar: UIImage(named: "mock_2"), isOnline: false)
  static let message  = Message(from: user3, to: me, date: Date(timeIntervalSince1970: Date().timeIntervalSince1970 - 3600 * 4), text: "There are a lot of premium iOS templates on iosapptemplates.com")
  static var previews: some View {
    MessageView(currentMessage: message)
  }
}
