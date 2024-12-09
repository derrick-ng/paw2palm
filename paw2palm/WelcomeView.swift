//
//  WelcomeView.swift
//  paw2palm
//
//  Created by Derrick Ng on 12/8/24.
//

import SwiftUI
import FirebaseAuth


struct WelcomeView: View {
    @State
    var showRegisterView = false
    
    @State
    var showLoginView = false
    
    @State
    var userLoggedIn = false
    
    var body: some View {
        Group {
            if userLoggedIn {
                HomepageView()
            }
            else {
                content
            }
        }
    }
    
    var content: some View {
        VStack {
            Text("Maybe an image here")
            Button("Login") {
                showLoginView = true
            }
            .sheet(isPresented: $showLoginView) {
                //throw in a bool(userLoggedIn) into LoginView, on success -> return true ??
                LoginView(userLoggedIn: $userLoggedIn)
            }
            
            Button("Sign Up") {
                showRegisterView = true
            }
            .sheet(isPresented: $showRegisterView) {
                RegisterView()
            }
        }
    }
}
