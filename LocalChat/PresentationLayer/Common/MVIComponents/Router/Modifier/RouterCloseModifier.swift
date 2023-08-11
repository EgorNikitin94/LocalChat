//
//  RouterCloseModifier.swift
//  amomessenger
//
//  Created by Egor Nikitin on 08/06/2023.
//  Copyright © 2023 amoCRM. All rights reserved.
//

import SwiftUI
import Combine

struct RouterCloseModifier: ViewModifier {
  
  // MARK: Public
  
  let publisher: AnyPublisher<Void, Never>
  
  // MARK: Private
  
  @Environment(\.presentationMode) private var presentationMode
  
  // MARK: Life cycle
  
  func body(content: Content) -> some View {
    content
      .onReceive(publisher) { _ in
        presentationMode.wrappedValue.dismiss()
      }
  }
}
