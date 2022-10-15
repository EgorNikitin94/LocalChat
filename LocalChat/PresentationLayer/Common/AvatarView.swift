//
//  AvatarView.swift
//  LocalChat
//
//  Created by Егор Никитин on 10/16/22.
//

import SwiftUI

enum AvatarViewSize {
  case large
  case small
}

struct AvatarView: View {
  let type: AvatarViewSize
  let avatar: UIImage?
  let userName: String
  let isOnline: Bool
  
  @Environment(\.colorScheme) private var colorScheme
  
  init(with vm: DialogListRowViewModel) {
    self.type = .large
    self.avatar = vm.userAvatar
    self.userName = vm.userName
    self.isOnline = vm.isUserOnline
  }
  
  var body: some View {
    ZStack {
      if let image = avatar {
        Image(uiImage: image)
          .resizable()
          .aspectRatio(contentMode: .fill)
          .clipShape(Circle())
      } else {
        ZStack {
          Color(.lightGray)
            .clipShape(Circle())
           
          Text("\(userName.first?.description ?? "")")
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
      .isHidden(!isOnline)
    }
    .frame(width: 60, height: 60)
  }
}
