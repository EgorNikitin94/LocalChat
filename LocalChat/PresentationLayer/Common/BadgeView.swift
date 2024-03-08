//
//  BadgeView.swift
//  LocalChat
//
//  Created by Егор Никитин on 10/16/22.
//

import SwiftUI

extension Binding where Value == String {
  init(badgeValue: Binding<UInt>, maxValue: UInt = 99) {
    self.init {
      if badgeValue.wrappedValue <= maxValue {
        String(badgeValue.wrappedValue)
      } else {
        "+" + String(maxValue)
      }
    } set: { newValue in
      badgeValue.wrappedValue = UInt(newValue) ?? 0
    }
  }
}

struct BadgeView: View {
  @Binding var number: String
  @Binding var muted: Bool
  @State var size: CGFloat
  
  @Environment(\.colorScheme) private var colorSheme
  
  var body: some View {
    Text(number)
      .foregroundColor(
        colorSheme == .dark && muted ? .black : .white
      )
      .padding(.horizontal, 4)
      .frame(minWidth: size, maxHeight: size)
      .background(muted ? Color.gray : Color.blue)
      .clipShape(Capsule())
      .contentTransition(.numericText(countsDown: false))
      .animation(.easeIn, value: muted)
  }
}

fileprivate struct BadgeViewPreview: View {
  @State var bage: UInt = 990
  @State var muted: Bool = true
  var body: some View {
    VStack {
      BadgeView(
        number: Binding(
          badgeValue: $bage,
          maxValue: 999
        ),
        muted: $muted,
        size: 30
      )
      
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
      
      Button("Mute") {
        muted.toggle()
      }
    }
  }
}

#Preview("Light") {
  BadgeViewPreview()
}

#Preview("Dark") {
  BadgeViewPreview()
    .preferredColorScheme(.dark)
}
