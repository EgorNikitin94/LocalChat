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
      List(viewModel.dialogs, rowContent: { dialogVM in
        NavigationLink(value: dialogVM) {
          DialogListRowView(dialogVM: dialogVM)
        }
      })
      .listStyle(.plain)
      .padding(.horizontal, -15)
      .navigationTitle("Team")
      .navigationDestination(for: DialogListRowViewModel.self) { dialogVM in
        ConversationView(user: dialogVM.baseModel.user)
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
