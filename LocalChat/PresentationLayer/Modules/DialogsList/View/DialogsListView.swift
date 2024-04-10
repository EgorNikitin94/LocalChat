//
//  DialogsListView.swift
//  LocalChat
//
//  Created by Egor Nikitin on 11/08/2023.
//  Copyright © 2023 Egor Nikitin. All rights reserved.
//

import SwiftUI

struct DialogsListView: View {
  
  @State var container: ModernMVIContainer<DialogsListIntentProtocol, DialogsListModelStateProtocol>
  
  private var intent: DialogsListIntentProtocol { container.intent }
  private var model: DialogsListModelStateProtocol { container.model }
  
  @State var badge: String = "9"
  @State var muted: Bool = false
  
  var body: some View {
    ScrollView(.vertical) {
      LazyVStack(spacing: .zero, pinnedViews: .sectionHeaders) {
        Section {
          ForEach(model.dialogs) { dialogVM in
            DialogListRowView(dialogVM: dialogVM)
              .padding(.vertical, 15)
              .contextMenu {
                Button {
                  //
                } label: {
                  Label("Pin", systemImage: "pin.fill")
                }
                
                Button {
                  intent.mute(vm: dialogVM)
                } label: {
                  if dialogVM.muted {
                    Label("Enable notifications", systemImage: "bell.fill")
                  } else {
                    Label("Disable notifications", systemImage: "bell.slash.fill")
                  }
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
        } header: {
          VStack(alignment: .leading) {
            HStack(spacing: 20) {
              Group {
                Button(action: {}, label: {
                  HStack(spacing: 5) {
                    Text("All")
                    BadgeView(number: $badge, muted: $muted, size: 17)
                  }
                })
                
                Button(action: {}, label: {
                  HStack(spacing: 5) {
                    Text("Directs")
                    BadgeView(number: $badge, muted: $muted, size: 17)
                  }
                })
                
                Button(action: {}, label: {
                  HStack(spacing: 5) {
                    Text("Groups")
                    BadgeView(number: $badge, muted: $muted, size: 17)
                  }
                })
                Spacer()
              }
              .foregroundStyle(.blue)
            }
            
            
            Capsule(style: .continuous)
              .fill(.blue)
              .frame(width: 40, height: 3)
          }
          .padding(.vertical, 5)
          .padding(.horizontal, 15)
          .frame(maxHeight: 40)
          .background(.background, in: Rectangle())
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
    .toolbarBackground(.automatic, for: .navigationBar)
    .toolbarBackground(.background, for: .navigationBar)
    .onAppear(perform: intent.viewOnAppear)
    .modifier(DialogsListRouter(subjects: model.routerSubject, intent: intent))
  }
}


#Preview {
  NavigationStack {
    DialogsListAssembly().build(moduleOutput: nil, completion: nil)
      .preferredColorScheme(.dark)
  }
}
