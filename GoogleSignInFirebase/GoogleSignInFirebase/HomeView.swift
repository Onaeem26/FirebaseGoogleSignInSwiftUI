//
//  HomeView.swift
//  GoogleSignInFirebase
//
//  Created by Muhammad Osama Naeem on 11/8/21.
//

import SwiftUI
import Firebase
import GoogleSignIn

struct HomeView: View {
    @State var user = User()
    @AppStorage("loginStatus") var loginStatus = false
    var body: some View {
        VStack(spacing: 20) {
            Text("Welcome,\(user.name)")
                .onAppear {
                    guard let user = Auth.auth().currentUser else { return }
                    self.user = User(id: user.uid, name: user.displayName ?? "", email: user.email ?? "")
            }
            
            Button {
                GIDSignIn.sharedInstance.signOut()
                try? Auth.auth().signOut()
                
                withAnimation {
                    self.loginStatus = false
                }
            } label: {
                Text("Log Out")
            }

        }
    }
}


