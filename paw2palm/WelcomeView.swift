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
    
    @State
    var authListenerHandle: AuthStateDidChangeListenerHandle?
    
    var body: some View {
        Group {
            if userLoggedIn {
                HomepageView()
            }
            else {
                content
            }
        }
        .onAppear {
            setupAuthListener()
        }
        .onDisappear {
            removeAuthListener()
        }
    }
    
    var content: some View {
        VStack {
            TitleComponent()
            Text("Maybe an image here")
            Button("Login") {
                showLoginView = true
            }
            .sheet(isPresented: $showLoginView) {
                LoginView()
            }
            
            Button("Sign Up") {
                showRegisterView = true
            }
            .sheet(isPresented: $showRegisterView) {
                RegisterView()
            }
        }
//        .onAppear() {
//            Auth.auth().addStateDidChangeListener { auth, user in
//                if let user = user {
//                    userLoggedIn.toggle()
//                }
//            }
//        }
//        .onDisappear {
//            if let handle = authListenerHandle {
//                Auth.auth().removeStateDidChangeListener(handle) // Clean up the listener when the view disappears
//            }
//        }
        
    }
    private func setupAuthListener() {
       authListenerHandle = Auth.auth().addStateDidChangeListener { _, user in
           userLoggedIn = (user != nil)
       }
   }
   
   private func removeAuthListener() {
       if let handle = authListenerHandle {
           Auth.auth().removeStateDidChangeListener(handle)
       }
   }
}
