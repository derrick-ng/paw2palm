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
    
    @Binding
    var email: String
    
    @State
    var bio: String = ""
    
    var body: some View {
        VStack {
            Text("\(parseEmail(userEmail: email) ?? "")'s Profile")
            TextEditor(text: $bio)
            Button("Save") {
                saveBio()
            }
            Button("Sign Out") {
                logout()
            }
        }
        .onAppear() {
            fetchBio()
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
    
    func parseEmail(userEmail: String) -> String? {
        let emailComponents = userEmail.components(separatedBy: "@")
        return emailComponents.first
    }
    
    func fetchBio() {
        let defaults = UserDefaults.standard
        if let savedBio = defaults.string(forKey: "\(email)bio") {
            bio = savedBio
        }
    }
    
    func saveBio() {
        let defaults = UserDefaults.standard
        defaults.set(bio, forKey: "\(email)bio")
        print("biography save success")
    }
}
