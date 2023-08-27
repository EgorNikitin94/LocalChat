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
      Color.clear.padding(.bottom, 5)
      LazyVStack(spacing: 15) {
        ForEach(model.dialogs) { dialogVM in
          DialogListRowView(dialogVM: dialogVM)
            .contextMenu {
              Button {
                //
              } label: {
                Text("закрепить")
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
      Color.clear.padding(.bottom, 5)
    }
    .navigationTitle("Team")
    .navigationBarTitleDisplayMode(.inline)
    .navigationBarBackButtonHidden()
    .toolbar {
      Button {
        intent.openProfile()
      } label: {
        Image(systemName: "gearshape.fill")
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
