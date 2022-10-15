//
//  DialogListRowView.swift
//  LocalChat
//
//  Created by Егор Никитин on 10/8/22.
//

import SwiftUI

struct DialogListRowView: View {
  
  let dialog: Dialog
  
  @Environment(\.colorScheme) private var colorScheme
  
    var body: some View {
      HStack {
        ZStack {
          if let image = dialog.user.avatar {
            Image(uiImage: image)
              .resizable()
              .aspectRatio(contentMode: .fill)
              .frame(width: 60, height: 60)
              .clipShape(Circle())
          } else {
            ZStack {
              Color(.lightGray)
                .clipShape(Circle())
                .frame(width: 60, height: 60)
              Text("\(dialog.user.name.first?.description ?? "")")
                .foregroundColor(colorScheme == .light ? .white : .black)
                .font(.largeTitle)
                .bold()
            }
          }
          ZStack {
            Circle()
            .frame(width: 15, height: 15)
            .foregroundColor(colorScheme == .light ? .white : .black)
            Color.green
              .frame(width: 10, height: 10)
              .clipShape(Circle())
          }
          .offset(x: 20, y: 22)
          .isHidden(!dialog.user.isOnline)
        }
        HStack {
          VStack(spacing: 3) {
            HStack {
              Text(dialog.user.name)
                .font(.system(size: 22))
              Spacer()
              
              if let dialogLastMessageDate = dialog.lastMessageDate {
                Text(dialogLastMessageDate)
                  .font(.caption2)
                  .foregroundColor(.gray)
              }
            }
            if let message = dialog.lastMessage {
              HStack {
                Text(message.text)
                  .foregroundColor(Color.gray)
                  .lineLimit(2)
                Spacer()
                ZStack {
                  Color.blue
                    .frame(width: 30, height: 30)
                    .clipShape(Circle())
                  Text("\(dialog.unreadCount)")
                    .foregroundColor(.white)
                }
                .isHidden(dialog.unreadCount == 0)
              }
            }
          }
        }
      }
      .padding(.horizontal, 5)
      .frame(height: 60)
    }
  
  init(dialog: Dialog) {
    self.dialog = dialog
  }
}

struct DialogListRowView_Previews: PreviewProvider {
  static let me = User(type: .selfUser, name: "Mike", passsword: "123", avatar: nil, isOnline: true)
  static let user = User(type: .anotherUser, name: "John", passsword: "1123", avatar: nil, isOnline: true)
    static var previews: some View {
      DialogListRowView(dialog: Dialog(user: user,
                                         lastMessage: Message(from: user, to: me, date: Date(), text: "Hallo! Whats the problem?")))
      .previewLayout(.fixed(width: 400, height: 80))
    }
}
