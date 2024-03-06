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
      Text(numberString)
        .foregroundColor(.white)
        .padding(.horizontal, 4)
        .frame(minWidth: size, maxHeight: size)
        .background(Color.blue)
        .clipShape(Capsule())
        .contentTransition(.numericText(countsDown: false))
    }
}

fileprivate struct BadgeViewPreview: View {
  @State var bage: Int = 90
  var body: some View {
    VStack {
      BadgeView(number: bage)
      
      Button("Increment") {
        withAnimation(.bouncy) {
          bage += 1
        }
      }
      
      Button("Decriment") {
        withAnimation(.bouncy) {
          bage -= 1
        }
      }
      
      Button("Zero") {
        withAnimation(.bouncy) {
          bage = 0
        }
      }
    }
  }
}

#Preview {
  BadgeViewPreview()
}
