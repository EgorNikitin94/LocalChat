//
//  ContentMessageView.swift
//  LocalChat
//
//  Created by Егор Никитин on 10/12/22.
//

import SwiftUI

struct ContentMessageView: View {
  @StateObject var currentMessage: MessageDisplayItem
  
  @Environment(\.colorScheme) private var colorScheme
  
  var body: some View {
    ChatBubble(direction: currentMessage.isFromCurrentUser ? .right : .left,
               isEndOfSequence: currentMessage.isEndOfSequence) {
      VStack(alignment: .trailing, spacing: 4) {
        Text(currentMessage.textContent)
          .font(.system(size: 16))
        
        Text(currentMessage.dateText)
          .foregroundColor(currentMessage.isFromCurrentUser ? Color.white : colorScheme == .light ? Color.gray : .white)
          .font(.system(size: 10))
      }
      .foregroundColor(currentMessage.isFromCurrentUser ? Color.white : colorScheme == .light ? Color.black : .white)
      .padding(10)
      .background(currentMessage.isFromCurrentUser ? Color.blue : colorScheme == .light ? Color(UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)) : Color(uiColor: .systemGray3))
    }
  }
}

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

struct ChatBubbleShape: Shape {
  
  enum Direction {
    case left
    case right
  }
  
  let direction: Direction
  let isEndOfSequence: Bool
  
  func path(in rect: CGRect) -> Path {
    guard isEndOfSequence else {
      return getBubblePath(in: rect)
    }
    return direction == .left ? getLeftBubblePath(in: rect) : getReghtBubblePath(in: rect)
  }
  
  func getLeftBubblePath(in rect: CGRect) -> Path {
    let width = rect.width
    let height = rect.height
    let path = Path { p in
      p.move(to: CGPoint(x: 25, y: height))
      p.addLine(to: CGPoint(x: width - 20, y: height))
      p.addCurve(to: CGPoint(x: width, y: height - 20),
                 control1: CGPoint(x: width - 8, y: height),
                 control2: CGPoint(x: width, y: height - 8))
      p.addLine(to: CGPoint(x: width, y: 20))
      p.addCurve(to: CGPoint(x: width - 20, y: 0),
                 control1: CGPoint(x: width, y: 8),
                 control2: CGPoint(x: width - 8, y: 0))
      p.addLine(to: CGPoint(x: 21, y: 0))
      p.addCurve(to: CGPoint(x: 4, y: 20),
                 control1: CGPoint(x: 12, y: 0),
                 control2: CGPoint(x: 4, y: 8))
      p.addLine(to: CGPoint(x: 4, y: height - 11))
      p.addCurve(to: CGPoint(x: 0, y: height),
                 control1: CGPoint(x: 4, y: height - 1),
                 control2: CGPoint(x: 0, y: height))
      p.addLine(to: CGPoint(x: -0.05, y: height - 0.01))
      p.addCurve(to: CGPoint(x: 11.0, y: height - 4.0),
                 control1: CGPoint(x: 4.0, y: height + 0.5),
                 control2: CGPoint(x: 8, y: height - 1))
      p.addCurve(to: CGPoint(x: 25, y: height),
                 control1: CGPoint(x: 16, y: height),
                 control2: CGPoint(x: 20, y: height))
    }
    
    return path
    
  }
  
  func getBubblePath(in rect: CGRect) -> Path {
    let width = rect.width
    let height = rect.height
    let path = Path { p in
      p.move(to: CGPoint(x: 25, y: height))
      p.addLine(to: CGPoint(x: width - 20, y: height))
      p.addCurve(to: CGPoint(x: width, y: height - 20),
                 control1: CGPoint(x: width - 8, y: height),
                 control2: CGPoint(x: width, y: height - 8))
      p.addLine(to: CGPoint(x: width, y: 20))
      p.addCurve(to: CGPoint(x: width - 20, y: 0),
                 control1: CGPoint(x: width, y: 8),
                 control2: CGPoint(x: width - 8, y: 0))
      p.addLine(to: CGPoint(x: 20, y: 0))
      p.addCurve(to: CGPoint(x: 0, y: 20),
                 control1: CGPoint(x: 8, y: 0),
                 control2: CGPoint(x: 0, y: 8))
      p.addLine(to: CGPoint(x: 0, y: height - 20))
      p.addCurve(to: CGPoint(x: 20, y: height),
                 control1: CGPoint(x: 0, y: height - 8),
                 control2: CGPoint(x: 8, y: height))
      
    }
    
    return path
    
  }
  
  func getReghtBubblePath(in rect: CGRect) -> Path {
    let width = rect.width
    let height = rect.height
    let path = Path { p in
      p.move(to: CGPoint(x: 25, y: height))
      p.addLine(to: CGPoint(x:  20, y: height))
      p.addCurve(to: CGPoint(x: 0, y: height - 20),
                 control1: CGPoint(x: 8, y: height),
                 control2: CGPoint(x: 0, y: height - 8))
      p.addLine(to: CGPoint(x: 0, y: 20))
      p.addCurve(to: CGPoint(x: 20, y: 0),
                 control1: CGPoint(x: 0, y: 8),
                 control2: CGPoint(x: 8, y: 0))
      p.addLine(to: CGPoint(x: width - 21, y: 0))
      p.addCurve(to: CGPoint(x: width - 4, y: 20),
                 control1: CGPoint(x: width - 12, y: 0),
                 control2: CGPoint(x: width - 4, y: 8))
      p.addLine(to: CGPoint(x: width - 4, y: height - 11))
      p.addCurve(to: CGPoint(x: width, y: height),
                 control1: CGPoint(x: width - 4, y: height - 1),
                 control2: CGPoint(x: width, y: height))
      p.addLine(to: CGPoint(x: width + 0.05, y: height - 0.01))
      p.addCurve(to: CGPoint(x: width - 11, y: height - 4),
                 control1: CGPoint(x: width - 4, y: height + 0.5),
                 control2: CGPoint(x: width - 8, y: height - 1))
      p.addCurve(to: CGPoint(x: width - 25, y: height),
                 control1: CGPoint(x: width - 16, y: height),
                 control2: CGPoint(x: width - 20, y: height))
    }
    
    return path
  }
  
}

struct ContentMessageView_Previews: PreviewProvider {
  static let me = User(type: .selfUser, name: "Mike", passsword: "123", avatar: nil, isOnline: true)
  static let user3 = User(type: .anotherUser, name: "Sarra Bold", passsword: "1123", avatar: UIImage(named: "mock_2"), isOnline: false)
  static let message  = Message(from: user3, to: me, date: Date(timeIntervalSince1970: Date().timeIntervalSince1970 - 3600 * 4), text: "There are a lot of premium iOS templates on iosapptemplates.com")
  static var previews: some View {
    ContentMessageView(currentMessage: MessageDisplayItem(with: message))
  }
}
