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
        VStack{
            //pf head
            
            //pf pic placeholder
            VStack {
                Circle()
                    .fill(Color.black.opacity(0.3))
                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/,height: 100)
                
                Text("\(parseEmail(userEmail: email) ?? "")'s Profile")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            }.padding()
            
            //for bio
            VStack(alignment: .center){
                Text("Bio")
                    .font(.headline)
                    
                TextEditor(text: $bio)
                    .frame(height: 150)
                                       .padding(10)
                                       .background(Color.gray.opacity(0.2))
                                       .cornerRadius(10)
                                       .overlay(
                                           RoundedRectangle(cornerRadius: 10)
                                               .stroke(Color.gray.opacity(0.5), lineWidth: 2)
                                       )
                VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
                   
                    Button("Save") {
                        saveBio()
                    } .foregroundColor(.white)
                        .frame(width: 300, height: 50)
                        .background(Color.blue)
                        .cornerRadius(10)
                    Button("Sign Out") {
                        logout()
                    } .foregroundColor(.white)
                        .frame(width: 300, height: 50)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
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
