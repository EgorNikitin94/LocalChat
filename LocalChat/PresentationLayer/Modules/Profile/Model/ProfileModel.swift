//
//  ProfileModel.swift
//  LocalChat
//
//  Created by Egor Nikitin on 11/08/2023.
//  Copyright © 2023 Egor Nikitin. All rights reserved.
//

import SwiftUI
import Observation

struct ProfileSectionDisplayItem: Identifiable {
  enum SectionHeaderType {
    case none
    case userInfo(avatar: UIImage, name: String, phone: String)
  }
  let id: UUID = UUID()
  var section: SectionHeaderType
  var items: [ProfileDisplayItem] = []
}

enum ProfileDisplayItem: Hashable {
  case button(title: String)
  case base(title: String, imageName: String, imageColor: Color)
}

@Observable
class ProfileModel: ProfileModelStateProtocol {
  var sections: [ProfileSectionDisplayItem] = []
  let routerSubject = ProfileRouter.Subjects()
  
  private func buildSections(with user: User) -> [ProfileSectionDisplayItem] {
    let baseSection = ProfileSectionDisplayItem(
      section: .userInfo(
        avatar: user.avatar!,
        name: user.name,
        phone: user.phone
      ),
      items: [
        .base(title: "Notifications and sounds", imageName: "app.badge.fill", imageColor: .red),
        .base(title: "Storage and memory", imageName: "square.stack.3d.up.fill", imageColor: .blue),
        .base(title: "Appearance", imageName: "circle.lefthalf.filled.inverse", imageColor: .yellow),
        .base(title: "Language", imageName: "globe", imageColor: .green)
      ]
    )
    
    let infoSection = ProfileSectionDisplayItem(
      section: .none,
      items: [
        .base(title: "About app", imageName: "iphone.gen3", imageColor: .orange),
        .base(title: "Help", imageName: "questionmark.circle.fill", imageColor: .mint)
      ]
    )
    
    let logoutSection = ProfileSectionDisplayItem(
      section: .none,
      items: [
        .button(title: "Logout")
      ]
    )
    return [baseSection, infoSection, logoutSection]
  }
}

// MARK: - Actions
extension ProfileModel: ProfileModelActionsProtocol {
  func newEvent(_ event: ProfileEvent) {
    switch event {
    case .initialState(let user):
      self.sections = buildSections(with: user)
    }
  }
}

// MARK: - Route
extension ProfileModel: ProfileModelRouterProtocol {
  
}
