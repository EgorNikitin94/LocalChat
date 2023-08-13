//
//  ChatBubble.swift
//  LocalChat
//
//  Created by Егор Никитин on 8/13/23.
//

import SwiftUI

struct ChatBubble<Content>: View where Content: View {
  let direction: ChatBubbleShape.Direction
  let isEndOfSequence: Bool
  let content: () -> Content
  
  init(direction: ChatBubbleShape.Direction, isEndOfSequence: Bool, @ViewBuilder content: @escaping () -> Content) {
    self.content = content
    self.direction = direction
    self.isEndOfSequence = isEndOfSequence
  }
  
  var body: some View {
    content()
      .clipShape(ChatBubbleShape(direction: direction, isEndOfSequence: isEndOfSequence))
  }
}
