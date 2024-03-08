//
//  DialogListRowView.swift
//  LocalChat
//
//  Created by Егор Никитин on 10/8/22.
//

import SwiftUI

struct DialogListRowView: View {
  
  @Bindable var dialogVM: DialogListDisplayItem
  
  var body: some View {
    HStack {
      AvatarView(
        displayItem: AvatarDisplayItem(
          with: dialogVM.baseModel.user
        ),
        needShowOnline: true
      )
      .squareSize(60)
      HStack {
        VStack(spacing: 3) {
          HStack {
            HStack(alignment: .lastTextBaseline, spacing: 4) {
              Text(dialogVM.userName)
                .font(.system(size: 22))
              
              if dialogVM.muted {
                Image(systemName: "bell.slash.fill")
                  .resizable()
                  .squareSize(12)
                  .foregroundColor(.gray)
                  .transition(.scale.combined(with: .opacity))
              }
            }
            
            Spacer()
            
            if let dialogLastMessageDate = dialogVM.lastMessageDate {
              Text(dialogLastMessageDate)
                .font(.caption2)
                .foregroundColor(.gray)
            }
          }
          .animation(.bouncy, value: dialogVM.muted)
          if let message = dialogVM.lastMessageText {
            HStack {
              Text(message)
                .foregroundColor(Color.gray)
                .lineLimit(2)
              Spacer()
              
              if dialogVM.unreadCount != 0 {
                BadgeView(
                  number: Binding(
                    badgeValue: $dialogVM.unreadCount
                  ),
                  muted: $dialogVM.muted,
                  size: 30
                )
              }
            }
          }
        }
      }
    }
    .padding(.horizontal, 5)
    .frame(height: 60)
  }
}

#Preview {
  let me = User(userType: .selfUser, name: "Mike", passsword: "123", avatar: nil, isOnline: true)
  let user = User(userType: .anotherUser, name: "John", passsword: "1123", avatar: nil, isOnline: true)
  return DialogListRowView(
    dialogVM: DialogListDisplayItem(
      dialog: Dialog(
        user: user,
        lastMessage: Message(
          from: user,
          to: me,
          date: Date(),
          text: "Hallo! Whats the problem?"
        ),
        unreadCount: 2,
        muted: true
      )
    )
  )
  .previewLayout(.fixed(width: 400, height: 80))
}
