//
//  ContentMessageView.swift
//  LocalChat
//
//  Created by Егор Никитин on 10/12/22.
//

import SwiftUI

struct ContentMessageView: View {
  var contentMessage: String
  var isCurrentUser: Bool
  var date: Date
  
  @Environment(\.colorScheme) private var colorScheme
  
  var body: some View {
    Text(contentMessage)
//      .overlay(alignment: .trailingLastTextBaseline) {
//        Text(TimeManagerHalper.makeString(from: date) ?? "")
//          .foregroundColor(isCurrentUser ? Color.white : colorScheme == .light ? Color.gray : .white)
//          .font(.system(size: 12))
//      }
      .padding(10)
      .foregroundColor(isCurrentUser ? Color.white : colorScheme == .light ? Color.black : .white)
      .background(isCurrentUser ? Color.blue : colorScheme == .light ? Color(UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)) : Color(uiColor: .systemGray3))
      .cornerRadius(10)
    
  }
}

struct ContentMessageView_Previews: PreviewProvider {
  static var previews: some View {
    ContentMessageView(contentMessage: "Hi, I am your friend", isCurrentUser: false, date: Date())
  }
}
