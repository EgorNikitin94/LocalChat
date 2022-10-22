//
//  PrifileView.swift
//  LocalChat
//
//  Created by Егор Никитин on 10/15/22.
//

import SwiftUI

struct ProfileView: View {
  let user: User = User(type: .selfUser, name: "Egor", passsword: "123", avatar: UIImage(named: "Me"), isOnline: true)
  
  var body: some View {
    List {
      VStack {
        Image(uiImage: user.avatar!)
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(width: 90, height: 90)
        .clipShape(Circle())
        
        Text(user.name)
          .font(.title)
          .bold()
      }
      
      Text("Change avatar")
          .foregroundColor(.blue)
      
      Text("Logout")
        .foregroundColor(.red)
      
    }
    .navigationBarTitle(Text("Profile"), displayMode: .inline)
  }
}

struct PrifileView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      ProfileView()
    }
  }
}
