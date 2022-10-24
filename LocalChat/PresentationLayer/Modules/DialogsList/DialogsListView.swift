//
//  DialogsListView.swift
//  LocalChat
//
//  Created by Егор Никитин on 10/8/22.
//

import SwiftUI

struct DialogsListView: View {
  
  @ObservedObject var viewModel: DialogsListViewModel
  
  var body: some View {
    List(viewModel.dialogs, rowContent: { dialogVM in
      NavigationLink {
        moduleAssembly.assemblyConversation(for: dialogVM.baseModel)
      } label: {
        DialogListRowView(dialogVM: dialogVM)
      }
    })
    .listStyle(.plain)
    .padding(.horizontal, -15)
    .navigationTitle("Team")
    .navigationBarTitleDisplayMode(.automatic)
    .toolbar {
      NavigationLink {
        moduleAssembly.assemblyProfile()
      } label: {
        Image(systemName: "gearshape.fill")
      }
    }
  }
}

struct DialogsListView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationStack {
      moduleAssembly.assemblyDialogsList()
    }
  }
}
