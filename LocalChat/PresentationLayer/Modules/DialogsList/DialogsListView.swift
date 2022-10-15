//
//  DialogsListView.swift
//  LocalChat
//
//  Created by Егор Никитин on 10/8/22.
//

import SwiftUI

struct DialogsListView: View {
  
  @ObservedObject var viewModel: DialogsListViewModel = DialogsListViewModel()
  
  @Binding var rootView : RootViewState
  
  var body: some View {
    NavigationStack {
      List(viewModel.dialigs, rowContent: { dialog in
        NavigationLink(value: dialog) {
          DialogListRowView(dialog: dialog)
        }
      })
      .listStyle(.plain)
      .padding(.horizontal, -15)
      .navigationTitle("Team")
      .navigationDestination(for: Dialog.self) { dialog in
        ConversationView(user: dialog.user)
      }
      .toolbar {
        NavigationLink {
          PrifileView()
        } label: {
          Image(systemName: "gearshape.fill")
        }
      }
    }
  }
}

struct DialogsListView_Previews: PreviewProvider {
  static var previews: some View {
    DialogsListView(rootView: .constant(.dialogs))
  }
}
