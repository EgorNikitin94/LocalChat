//
//  DialogListRowView.swift
//  LocalChat
//
//  Created by Егор Никитин on 10/8/22.
//

import SwiftUI

struct DialogListRowView: View {
  
  let dialogVM: DialogListRowViewModel
  
  @Environment(\.colorScheme) private var colorScheme
  
  init(dialogVM: DialogListRowViewModel) {
    self.dialogVM = dialogVM
  }
  
  var body: some View {
    HStack {
      AvatarView(displayItem: AvatarDisplayItem(with: dialogVM.baseModel.user), needShowOnline: true)
        .frame(width: 60, height: 60)
      HStack {
        VStack(spacing: 3) {
          HStack {
            Text(dialogVM.userName)
              .font(.system(size: 22))
            
            Spacer()
            
            if let dialogLastMessageDate = dialogVM.lastMessageDate {
              Text(dialogLastMessageDate)
                .font(.caption2)
                .foregroundColor(.gray)
            }
          }
          if let message = dialogVM.lastMessageText {
            HStack {
              Text(message)
                .foregroundColor(Color.gray)
                .lineLimit(2)
              Spacer()
              
              BadgeView(number: dialogVM.unreadCount)
                .isHidden(dialogVM.unreadCount == 0)
            }
          }
        }
      }
    }
    .padding(.horizontal, 5)
    .frame(height: 60)
  }
}

struct DialogListRowView_Previews: PreviewProvider {
  static let me = User(type: .selfUser, name: "Mike", passsword: "123", avatar: nil, isOnline: true)
  static let user = User(type: .anotherUser, name: "John", passsword: "1123", avatar: nil, isOnline: true)
  static var previews: some View {
    DialogListRowView(dialogVM: DialogListRowViewModel(dialog: Dialog(user: user,
                                                                      lastMessage: Message(from: user, to: me, date: Date(), text: "Hallo! Whats the problem?"))))
    .previewLayout(.fixed(width: 400, height: 80))
  }
}
