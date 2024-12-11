//
//  RegisterView.swift
//  paw2palm
//
//  Created by Derrick Ng on 12/8/24.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct RegisterView: View {
    @State
    var email = ""
    
    @State
    var password = ""
    
    @State
    var errorMessage: String?
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("Sign Up")
                .font(.largeTitle)
                .bold()
                .padding()
            // bordered error message
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                   .font(.footnote)
                   .multilineTextAlignment(.center)
                   .padding()
                   .background(Color.gray.opacity(0.2))
                   .cornerRadius(10)
                   .overlay(
                       RoundedRectangle(cornerRadius: 10)
                           .stroke(Color.gray, lineWidth: 1)
                   )
                   .padding(.top, 10)
            }
            TextField("email", text: $email)
                .padding()
                .frame(width: 300, height: 50)
                .background(Color.black.opacity(0.05))
                .cornerRadius(10)
            SecureField("Password", text: $password)
                .padding()
                .frame(width: 300, height: 50)
                .background(Color.black.opacity(0.05))
            
            Button("Sign Up") {
                register()
            }.foregroundColor(.white)
                .frame(width: 300, height: 50)
                .background(Color.blue)
                .cornerRadius(10)
        }
    }
    
    func register() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("error in registration: \(error.localizedDescription)")
                errorMessage = error.localizedDescription
            }
            else {
                print("registration success")
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}
