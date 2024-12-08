//
//  ProfileView.swift
//  paw2palm
//
//  Created by Robin Pilapil on 12/5/24.
//
import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    
    @Binding
    var userLoggedIn: Bool
    
    var body: some View {
        VStack {
            Text("User Profile")
            Button("Sign Out") {
                logout()
            }
        }
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
            print("logout success")
            userLoggedIn = false
        } catch let error as NSError {
            print("error in logout: \(error.localizedDescription)")
        }
    }
}
