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
                HomepageView(userLoggedIn: $userLoggedIn)
            }
            else {
                content
            }
        }
    }
    
    var content: some View {
        VStack {
            Image(.IMG_7587)
                .resizable()
               .aspectRatio(contentMode: .fit)
               .clipShape(RoundedRectangle(cornerRadius: 25))
               .padding()
            Button("Login") {
                showLoginView = true
            }
                .foregroundColor(.white)
                .frame(width: 300, height: 50)
                .background(Color.cyan)
                .cornerRadius(10)
                .sheet(isPresented: $showLoginView) {
                //throw in a bool(userLoggedIn) into LoginView, on success -> return true ??
                LoginView(userLoggedIn: $userLoggedIn)
            }
            
            Button("Sign Up") {
                showRegisterView = true
            }
            .foregroundColor(.white)
                .frame(width: 300, height: 50)
                .background(Color.blue)
                .cornerRadius(10)
            .sheet(isPresented: $showRegisterView) {
                RegisterView()
            }
        }
    }
}
