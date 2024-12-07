//
//  LoginView.swift
//  paw2palm
//
//  Created by Robin Pilapil on 12/6/24.
//

import SwiftUI

struct LoginView: View {
    // FROM YT Tutorial: https://www.youtube.com/watch?v=l7obVQObdRM&t=26s
    @State
    var username = ""
    
    @State
    var password = ""
    
    @State
    var wrongUser = true
    
    @State
    var wrongPassword = true
    
    @State
    var isAuthenticated = false
    
    
    var body: some View {
        
            NavigationStack{
                VStack{
                    Text("Login")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    TextField("Username", text: $username)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                    SecureField("Password", text: $password)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                    Button("Login"){
                        print("Made it into button")
                        
                        authentificationUser(username: username, password: password)
                    }              .foregroundColor(.white)
                        .frame(width: 300, height: 50)
                        .background(Color.blue)
                        .cornerRadius(10)
                    
                   
                    
                    
                }
                .navigationDestination(isPresented: $isAuthenticated){
                                                            HomepageView()
                                                        }
            }.navigationBarHidden(true)
            
            
        }
        func authentificationUser(username: String, password: String){
            if username.lowercased() == "user1"{
                wrongUser = false
                if password.lowercased() == "1234"{
                    wrongPassword = false
                    isAuthenticated = true
                    print("made it into authentification")
                }else{
                    wrongPassword = true
                }
            }else{
                wrongUser = true
            }
        }
           
     
           
      
    
}
