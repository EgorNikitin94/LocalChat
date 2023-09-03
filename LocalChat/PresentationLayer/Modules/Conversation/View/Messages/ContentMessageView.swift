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
      Group {
        switch currentMessage.messageContentType {
        case .text:
          TextContentMessageView(currentMessage: currentMessage)
        case .image:
          ImageContentMessageView(currentMessage: currentMessage)
        }
      }
      .background(currentMessage.isFromCurrentUser ? Color.blue : colorScheme == .light ? Color(UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)) : Color(uiColor: .systemGray3))
    }
  }
}

struct GeometryGetter: View {
  @Binding var rect: CGRect
  
  var body: some View {
    return GeometryReader { geometry in
      self.makeView(geometry: geometry)
    }
  }
  
  func makeView(geometry: GeometryProxy) -> some View {
    DispatchQueue.main.async {
      self.rect = geometry.frame(in: .global)
    }
    
    return Rectangle().fill(Color.clear)
  }
}

//struct MessageContentLayout: Layout {
//  func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
//    let first = subviews.first?.sizeThatFits(.unspecified)
//    return proposal.replacingUnspecifiedDimensions()//CGSize(width: proposal.width ?? 0.0, height: proposal.height ?? 0.0)
//  }
//
//  func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
//    //
//  }
//}

struct TextContentMessageView: View {
  enum TextAndDatePlacement {
    case vstack
    case hstack
    case zstack
  }
  @StateObject var currentMessage: MessageDisplayItem
  
  @Environment(\.colorScheme) private var colorScheme
  
  @State private var textMessageRect: CGRect = .zero
  @State private var dateRect: CGRect = .zero
  @State var placement: TextAndDatePlacement = .zstack
  
  var body: some View {
    let Layout = placement == .vstack ? AnyLayout(VStackLayout(alignment: .trailing, spacing: 4)) : (placement == .hstack ? AnyLayout(HStackLayout(alignment: .lastTextBaseline, spacing: 4)) : AnyLayout(ZStackLayout(alignment: .trailingLastTextBaseline)))
    
    //VStack(alignment: .trailing, spacing: 4) {
    Layout {
    //MessageContentLayout {
      Text(currentMessage.textContent)
        .font(.system(size: 16))
        .background { GeometryGetter(rect: $textMessageRect) }
        .onChange(of: textMessageRect) { textMessageRect in
          calculateLayout()
        }
      
      Text(currentMessage.dateText)
        .foregroundColor(currentMessage.isFromCurrentUser ? Color.white : colorScheme == .light ? Color.gray : .white)
        .font(.system(size: 12))
        .background { GeometryGetter(rect: $dateRect) }
    }
    .foregroundColor(currentMessage.isFromCurrentUser ? Color.white : colorScheme == .light ? Color.black : .white)
    .padding(10)
  }
  
  private func calculateLayout() {
    let textStorage = NSTextStorage(string: currentMessage.textContent)
    let layoutManager = NSLayoutManager()
    textStorage.addLayoutManager(layoutManager)
    let textContainer = NSTextContainer(size: textMessageRect.size)
    textContainer.lineFragmentPadding = 0
    textContainer.heightTracksTextView = true
    layoutManager.addTextContainer(textContainer)
    let point = layoutManager.lineFragmentRect(forGlyphAt: layoutManager.numberOfGlyphs, effectiveRange: nil)
    if UIScreen.main.bounds.size.width * 0.7 > textMessageRect.size.width + dateRect.size.width {
      placement = .hstack
    } else {
      if textMessageRect.size.width - point.maxX < dateRect.size.width + 4.0 {
        placement = .vstack
      } else {
        placement = .zstack
      }
    }
  }
}

struct ImageContentMessageView: View {
  @StateObject var currentMessage: MessageDisplayItem
  
  @Environment(\.colorScheme) private var colorScheme
  
  var body: some View {
    ZStack(alignment: .bottomTrailing) {
      Image(uiImage: currentMessage.media!)
        .resizable()
        .frame(maxWidth: 300, maxHeight: 400)
        .cornerRadius(14)
        .padding(5)
      
      Text(currentMessage.dateText)
        .foregroundColor(colorScheme == .light ? Color.gray : .white)
        .font(.system(size: 10))
        .padding(.horizontal, 6)
        .padding(.vertical, 3)
        .background {
          Color(uiColor: .systemGray6)
        }
        .cornerRadius(17)
        .padding(10)
    }
      .padding(.trailing, currentMessage.isEndOfSequence ? 4 : 0)
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
