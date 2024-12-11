//
//  LoginView.swift
//  paw2palm
//
//  Created by Robin Pilapil on 12/6/24.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    // FROM YT Tutorial: https://www.youtube.com/watch?v=l7obVQObdRM&t=26s
    
    //connects the value of userLoggedIn from WelcomeView and LoginView
    @Binding
    var userLoggedIn: Bool
    
    @Binding
    var email: String
    
    @State
    var password = ""
    
    @State
    var errorMessage: String?
    
    //used to hide the screen when finished using view
    @Environment(\.presentationMode) var presentationMode
    
    @State
    var wrongUser = false
    
    @State
    var wrongPassword = false
    
    @State
    var isAuthenticated = false
    
    
    var body: some View {
        
            NavigationStack{
                VStack{
                    Text("Login")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                           .font(.footnote)
                           .multilineTextAlignment(.center)
                           .padding()
                           .background(Color.gray.opacity(0.2)) // Light gray background
                           .cornerRadius(10)
                           .overlay(
                               RoundedRectangle(cornerRadius: 10)
                                   .stroke(Color.gray, lineWidth: 1) // Light gray border
                           )
                           .padding(.top, 10)
                    }
                    TextField("Email", text: $email)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
//                        .border(.red, width: wrongUser ? 2: 0)
                    SecureField("Password", text: $password)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
//                        .border(.red, width: wrongPassword ? 2: 0)
                    
                    Button("Login"){
                        login()
                    }              .foregroundColor(.white)
                        .frame(width: 300, height: 50)
                        .background(Color.niceBlue)
                        .cornerRadius(10)
                    //add a progress view at some point
                   
                    
                    
                }
            }.navigationBarHidden(true)
        
            
        }
           
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("error in login: \(error.localizedDescription)")
                errorMessage = error.localizedDescription
            }
            else {
                print("login success")
                userLoggedIn = true
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
           
      
    
}

