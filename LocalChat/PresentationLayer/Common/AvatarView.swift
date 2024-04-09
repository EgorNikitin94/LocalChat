//
//  AvatarView.swift
//  LocalChat
//
//  Created by Егор Никитин on 10/16/22.
//

import SwiftUI
import Combine

enum AvatarViewSize {
  case large
  case small
}

class AvatarDisplayItem: ObservableObject {
  let type: AvatarViewSize
  @Published var avatar: UIImage?
  @Published var userName: String
  @Published var isOnline: Bool
  
  init(with user: User) {
    self.type = .large
    self.avatar = user.avatar
    self.userName = user.name
    self.isOnline = user.isOnline
  }
}

struct AvatarView: View {
  @StateObject var displayItem: AvatarDisplayItem
  let needShowOnline: Bool
  @Environment(\.colorScheme) private var colorScheme
  
  var body: some View {
    ZStack {
      if let image = displayItem.avatar {
        Image(uiImage: image)
          .resizable()
          .aspectRatio(contentMode: .fill)
          .clipShape(Circle())
      } else {
        ZStack {
          Color(.lightGray)
            .clipShape(Circle())
           
          Text("\(displayItem.userName.first?.description ?? "")")
            .foregroundColor(colorScheme == .light ? .white : .black)
            .font(.largeTitle)
            .bold()
            .padding(3)
            .minimumScaleFactor(0.3)
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
      .isHidden(needShowOnline ? !displayItem.isOnline : true)
    }
  }
}
