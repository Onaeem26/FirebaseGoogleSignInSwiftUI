//
//  ContentView.swift
//  GoogleSignInFirebase
//
//  Created by Muhammad Osama Naeem on 11/7/21.
//

import SwiftUI
import Firebase
import GoogleSignIn

struct ContentView: View {
    @AppStorage("loginStatus") var loginStatus = false
    var body: some View {
        if loginStatus {
            HomeView()
        }else {
            LoginView()
        }
       
    }
}


extension View {
    func getRootViewController() -> UIViewController {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .init()
        }
        
        guard let root = screen.windows.first?.rootViewController else {
            return .init()
        }
        
        return root
                
    }
}

