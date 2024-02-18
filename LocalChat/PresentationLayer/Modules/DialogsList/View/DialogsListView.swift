//
//  DialogsListView.swift
//  LocalChat
//
//  Created by Egor Nikitin on 11/08/2023.
//  Copyright © 2023 Egor Nikitin. All rights reserved.
//

import SwiftUI

struct DialogsListView: View {
  
  @StateObject var container: MVIContainer<DialogsListIntentProtocol, DialogsListModelStateProtocol>
  
  private var intent: DialogsListIntentProtocol { container.intent }
  private var model: DialogsListModelStateProtocol { container.model }
  
  var body: some View {
    ScrollView(.vertical) {
      LazyVStack(spacing: .zero) {
        ForEach(model.dialogs) { dialogVM in
          DialogListRowView(dialogVM: dialogVM)
            .padding(.vertical, 15)
            .contextMenu {
              Button {
                //
              } label: {
                Label("Закрепить", systemImage: "pin.fill")
              }
              
              Button {
                //
              } label: {
                Label("Отключить уведомления", systemImage: "bell.slash.fill")
              }
            }
            .onTapGesture {
              intent.openConversation(for: dialogVM)
            }
        }
        .separator(showLast : false) { item in
          Divider()
            .padding(.leading, 15)
        }
      }
    }
    .searchable(
      text: $container.model.searchText,
      isPresented: $container.model.isPresentedSearch
    )
    .scrollDismissesKeyboard(.immediately)
    .onChange(of: model.searchText, { oldValue, newValue in
      if oldValue != newValue {
        intent.search(with: newValue)
      }
    })
    .navigationTitle("Team")
    .navigationBarTitleDisplayMode(.inline)
    .navigationBarBackButtonHidden()
    .toolbar {
      Button {
        intent.openProfile()
      } label: {
        Image(systemName: "square.and.pencil")
          .foregroundColor(.secondary)
      }
    }
    .onAppear(perform: intent.viewOnAppear)
    .modifier(DialogsListRouter(subjects: model.routerSubject, intent: intent))
  }
}

struct DialogsListView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationStack {
      DialogsListAssembly().build(moduleOutput: nil, completion: nil)
    }
  }
}
