//
//  TracableScrollView.swift
//  LocalChat
//
//  Created by Егор Никитин on 9/2/23.
//

import SwiftUI
import Combine

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
  @State private var contentOffset: CGFloat = 0.0
  @State private var contentSize: CGSize = .zero
  @State private var containerSize: CGSize = .zero
  @State private var viewLoaded: Bool = false
  private let scrollProgressPublisher: PassthroughSubject<CGFloat, Never>
  
  public init(
    _ axes: Axis.Set = .vertical,
    showIndicators: Bool = true,
    scrollProgressPublisher: PassthroughSubject<CGFloat, Never>,
    @ViewBuilder content: () -> Content
  ) {
    self.axes = axes
    self.showIndicators = showIndicators
    self.scrollProgressPublisher = scrollProgressPublisher
    self.content = content()
  }
  
  public var body: some View {
    GeometryReader { outsideProxy in
      ScrollView(axes, showsIndicators: showIndicators) {
        ZStack(alignment: axes == .vertical ? .bottom : .leading) {
          GeometryReader { insideProxy in
            Color.clear
              .preference(
                key: ScrollOffsetPreferenceKey.self,
                value: [calculateContentOffset(
                  fromOutsideProxy: outsideProxy,
                  insideProxy: insideProxy
                )]
              )
              .onChange(of: insideProxy.size) { _, newValue in
                contentSize = newValue
              }
          }
          content
        }
      }
      .onAppear {
        viewLoaded = true
      }
      .onChange(of: outsideProxy.size) { _, newValue in
        containerSize = newValue
      }
      .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
        contentOffset = value[0]
        
        log(false)
        
        let contentSize = axes == .vertical ? contentSize.height : contentSize.width
        let containerSize = axes == .vertical ? containerSize.height : containerSize.width
        let scrollProgress = 1 - ((containerSize + abs(contentOffset)) / contentSize)
        if viewLoaded && contentSize != 0 {
          scrollProgressPublisher.send(scrollProgress)
        }
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
  
  private func log(_ enable: Bool) {
    if enable {
      let contentSize = axes == .vertical ? contentSize.height : contentSize.width
      let containerSize = axes == .vertical ? containerSize.height : containerSize.width
      print("@@@ --------------------------")
      print("@@@ contentOffset == \(contentOffset)")
      print("@@@ contentSize == \(contentSize)")
      print("@@@ containerSize == \(containerSize)")
      print("@@@ scrollProgress == \((containerSize + contentOffset) / contentSize)")
      print("@@@ --------------------------")
    }
  }
}

