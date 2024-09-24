//
//  Separator.swift
//  LocalChat
//
//  Created by Егор Никитин on 8/28/23.
//

import SwiftUI

struct ForEachWithSeparator<Data: RandomAccessCollection, Content: View, Separator: View>: View where Data.Element: Hashable {
  let data: Data // data to render
  let content: (Data.Element) -> Content // data item render
  let separator: (Data.Element) -> Separator // separator renderer
  let showLast: Bool // if true, shows the separator at the end of the list
  
  var body: some View {
    let size = data.count * 2 - (showLast ? 0 : 1)
    let firstIndex = data.indices.startIndex
    let dataSize = size < 0 ? 0 : size
    return ForEach(0..<dataSize, id: \.self) { i in
      let element = data[data.index(firstIndex, offsetBy: i / 2)]
      if i % 2 == 0 {
        content(element)
      } else {
        separator(element)
      }
    }
  }
}

extension ForEach where Data.Element: Hashable, Content: View {
  @MainActor func separator<Separator: View>(showLast: Bool = true,
                                  @ViewBuilder separator: @escaping (Data.Element) -> Separator) -> some View {
    ForEachWithSeparator(data: data,
                         content: content,
                         separator: separator,
                         showLast: showLast)
  }
}

