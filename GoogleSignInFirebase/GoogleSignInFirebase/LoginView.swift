//
//  LoginView.swift
//  GoogleSignInFirebase
//
//  Created by Muhammad Osama Naeem on 11/8/21.
//

import SwiftUI
import Firebase
import GoogleSignIn
import FirebaseFirestore

struct User {
    var id: String = ""
    var name: String = ""
    var email: String = ""
    
}

struct LoginView: View {
    @AppStorage("loginStatus") var loginStatus = false
    @State var presentSheet: Bool = false
    
    var body: some View {
        ZStack {
            Button {
                signInWithGoogle()
            } label: {
                Text("Log In using Google")
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(20)
                    .foregroundColor(Color.white)
            }
        }.fullScreenCover(isPresented: $presentSheet) {
                HomeView()
        }
        
       
    }
    
    func signInWithGoogle() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)

        // Start the sign in flow!
        
        GIDSignIn.sharedInstance.signIn(with: config, presenting: getRootViewController()) {  user, error in

          if let error = error {
            print(error)
            return
          }

          guard let authentication = user?.authentication,
                let idToken = authentication.idToken
          else {
            return
          }

          let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                         accessToken: authentication.accessToken)

            Auth.auth().signIn(with: credential) { result, err in
                if let err = error {
                  print(err)
                  return
                }
                
                guard let user = result?.user else { return }
                
                print(user.displayName ?? "Success!")
                self.presentSheet = true
                withAnimation {
                    self.loginStatus = true
                }
              
            }
        }
    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
