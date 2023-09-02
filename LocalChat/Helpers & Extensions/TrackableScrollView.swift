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
  let content: Content
  @State var contentOffset: CGFloat = 0.0
  @State var contentSize: CGFloat = 0.0
  @Binding var scrollProgress: CGFloat
  @State private var viewLoaded: Bool = false
  
  public init(_ axes: Axis.Set = .vertical, showIndicators: Bool = true, scrollProgress: Binding<CGFloat>, @ViewBuilder content: () -> Content) {
    self.axes = axes
    self.showIndicators = showIndicators
    self._scrollProgress = scrollProgress
    self.content = content()
  }
  
  public var body: some View {
    GeometryReader { outsideProxy in
      ScrollView(self.axes, showsIndicators: self.showIndicators) {
        ZStack(alignment: self.axes == .vertical ? .top : .leading) {
          GeometryReader { insideProxy in
            Color.clear
              .preference(key: ScrollOffsetPreferenceKey.self, value: [self.calculateContentOffset(fromOutsideProxy: outsideProxy, insideProxy: insideProxy)])
              .onChange(of: insideProxy.size) { newValue in
                contentSize = newValue.height
              }
          }
          VStack {
            self.content
          }
        }
        .onAppear {
          self.viewLoaded = true
        }
      }
      .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
        self.contentOffset = value[0]
//        print("contentOffset == \(self.contentOffset)")
//        print("contentSize == \(self.contentSize)")
//        print("scrollProgress == \(1.0 - (self.contentOffset / self.contentSize))")
        self.scrollProgress = viewLoaded ? 1.0 - (self.contentOffset / self.contentSize) : 0.0
      }
    }
  }
  
  private func calculateContentOffset(fromOutsideProxy outsideProxy: GeometryProxy, insideProxy: GeometryProxy) -> CGFloat {
    if axes == .vertical {
      return outsideProxy.frame(in: .global).minY - insideProxy.frame(in: .global).minY
    } else {
      return outsideProxy.frame(in: .global).minX - insideProxy.frame(in: .global).minX
    }
  }
}

