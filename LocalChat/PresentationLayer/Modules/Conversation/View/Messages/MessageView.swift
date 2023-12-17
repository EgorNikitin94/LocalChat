//
//  MessageView.swift
//  LocalChat
//
//  Created by Егор Никитин on 10/12/22.
//

import SwiftUI

struct MessageView: View {
  @StateObject var currentMessage: MessageDisplayItem
  @Environment(\.colorScheme) private var colorScheme
  
  var minBubleOffset: CGFloat = 30.0
  
  var body: some View {
    VStack(spacing: 10) {
      if let time = currentMessage.topDateCapsuleText, currentMessage.needShowTopDateCapsuleText {
        Text(time)
          .font(.system(size: 14))
          .foregroundColor(.gray)
          .padding(.horizontal, 6)
          .padding(.vertical, 3)
          .background {
            Color(uiColor: .systemGray6)
          }
          .cornerRadius(17)
      }
      HStack(alignment: .bottom, spacing: 5) {
        if !currentMessage.from.isCurrentUser {
  //        if let avatar = currentMessage.from.avatar {
  //          Image(uiImage: avatar)
  //            .resizable()
  //            .aspectRatio(contentMode: .fill)
  //            .frame(width: 40, height: 40)
  //            .clipShape(Circle())
  //        } else {
  //          ZStack {
  //            Color(.lightGray)
  //              .clipShape(Circle())
  //              .frame(width: 40, height: 40)
  //            Text("\(currentMessage.from.name.first?.description ?? "")")
  //              .foregroundColor(colorScheme == .light ? .white : .black)
  //              .font(.title)
  //              .bold()
  //          }
  //        }
        } else {
          Spacer(minLength: minBubleOffset)
        }
        ContentMessageView(currentMessage: currentMessage)
          .padding(.horizontal, currentMessage.isEndOfSequence ? 6 : 10)
          .padding(.bottom, currentMessage.isEndOfSequence ? 8 : 0)
        
        if !currentMessage.from.isCurrentUser {
          Spacer(minLength: minBubleOffset)
        }
      }
      .transition(AnyTransition.move(edge: .bottom).combined(with: .opacity))
    }
  }
}

struct MessageView_Previews: PreviewProvider {
  static let me = User(type: .selfUser, name: "Mike", passsword: "123", avatar: nil, isOnline: true)
  static let user3 = User(type: .anotherUser, name: "Sarra Bold", passsword: "1123", avatar: UIImage(named: "mock_2"), isOnline: false)
  static let message  = Message(from: user3, to: me, date: Date(timeIntervalSince1970: Date().timeIntervalSince1970 - 3600 * 4), text: "There are a lot of premium iOS templates on iosapptemplates.com")
  static var previews: some View {
    MessageView(currentMessage: MessageDisplayItem(with: message))
  }
}
