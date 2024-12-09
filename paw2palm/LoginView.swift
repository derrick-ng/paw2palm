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
    @State
    var email = ""
    
    @State
    var password = ""
    
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
                        print("Made it into button")
                        login()
//                        authentificationUser(username: username, password: password)
                    }              .foregroundColor(.white)
                        .frame(width: 300, height: 50)
                        .background(Color.blue)
                        .cornerRadius(10)
                    //add a progress view at some point
                   
                    
                    
                }
//                .navigationDestination(isPresented: $isAuthenticated){
//                                                            HomepageView()
//                                                        }
                
            }.navigationBarHidden(true)
            
            
        }
//    
//        func authentificationUser(username: String, password: String){
//            if username.lowercased() == "user1"{
//                wrongUser = false
//                if password.lowercased() == "1234"{
//                    wrongPassword = false
//                    isAuthenticated = true
//                    print("made it into authentification")
//                }else{
//                    wrongPassword = true
//                }
//            }else{
//                wrongUser = true
//            }
//        }
           
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("error in login: \(error.localizedDescription)")
            }
            else {
                print("login success")
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
           
      
    
}
