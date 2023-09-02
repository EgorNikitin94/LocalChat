//
//  TracableScrollView.swift
//  LocalChat
//
//  Created by Егор Никитин on 9/2/23.
//

import SwiftUI

struct ScrollOffsetPreferenceKey: PreferenceKey {
  typealias Value = [CGFloat]
  
  static var defaultValue: [CGFloat] = [0]
  
  static func reduce(value: inout [CGFloat], nextValue: () -> [CGFloat]) {
    value.append(contentsOf: nextValue())
  }
}

public struct TrackableScrollView<Content>: View where Content: View {
  let axes: Axis.Set
  let showIndicators: Bool
  @Binding var contentOffset: CGFloat
  let content: Content
  @State var contentSize: CGFloat = 0.0
  
  public init(_ axes: Axis.Set = .vertical, showIndicators: Bool = true, contentOffset: Binding<CGFloat>, @ViewBuilder content: () -> Content) {
    self.axes = axes
    self.showIndicators = showIndicators
    self._contentOffset = contentOffset
    self.content = content()
  }
  
  public var body: some View {
    GeometryReader { outsideProxy in
      ScrollView(self.axes, showsIndicators: self.showIndicators) {
        ZStack(alignment: self.axes == .vertical ? .top : .leading) {
          GeometryReader { insideProxy in
            Color.clear
              .preference(key: ScrollOffsetPreferenceKey.self, value: [self.calculateContentOffset(fromOutsideProxy: outsideProxy, insideProxy: insideProxy)])
          }
          VStack {
            self.content
          }
        }
        .background( GeometryReader { proxy in
          GeometryReader { proxy in
            //self.contentSize = proxy.size.height
            let _ = print("contentSize == \(proxy.size.height)")
            Color.clear
          }
        })
      }
      .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
        self.contentOffset = value[0]
        print("contentOffset == \(self.contentOffset)")
      }
    }
  }
  
  private func calculateContentOffset(fromOutsideProxy outsideProxy: GeometryProxy, insideProxy: GeometryProxy) -> CGFloat {
    if axes == .vertical {
      return outsideProxy.frame(in: .global).maxY - insideProxy.frame(in: .global).minY
    } else {
      return outsideProxy.frame(in: .global).minX - insideProxy.frame(in: .global).minX
    }
  }
}

