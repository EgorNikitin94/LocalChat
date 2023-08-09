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
//      NavigationLink {
//      } label: {
        DialogListRowView(dialogVM: dialogVM)
        .onTapGesture {
          viewModel.openConversation(for: dialogVM)
        }
//      }
    })
    .listStyle(.plain)
    .padding(.horizontal, -15)
    .navigationTitle("Team")
    .navigationBarTitleDisplayMode(.automatic)
    .navigationBarBackButtonHidden()
    .toolbar {
//      NavigationLink {
//        viewModel.openProfile()
//      } label: {
        Image(systemName: "gearshape.fill")
        .onTapGesture {
          viewModel.openProfile()
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
