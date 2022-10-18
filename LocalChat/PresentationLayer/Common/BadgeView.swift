//
//  BadgeView.swift
//  LocalChat
//
//  Created by Егор Никитин on 10/16/22.
//

import SwiftUI

struct BadgeView: View {
  
  let size: CGFloat
  let number: Int
  var numberString: String {
    return number > 99 ? "99+" : "\(number)"
  }
  
  init(size: CGFloat = 30, number: Int) {
    self.size = size
    self.number = number
  }
  
    var body: some View {
      ZStack {
        Color.blue
          .frame(width: number > 99 ? size + 12 : size, height: size)
          .clipShape(RoundedRectangle(cornerRadius: 100))
        Text(numberString)
          .foregroundColor(.white)
      }
    }
}

struct BadgeView_Previews: PreviewProvider {
    static var previews: some View {
        BadgeView(number: 10)
    }
}
