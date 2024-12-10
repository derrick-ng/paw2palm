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
            TextField("email", text: $email)
                .padding()
                .frame(width: 300, height: 50)
                .background(Color.black.opacity(0.05))
                .cornerRadius(10)
            SecureField("Password", text: $password)
                .padding()
                .frame(width: 300, height: 50)
                .background(Color.black.opacity(0.05))
            if let errorMessage = errorMessage {
                Text(errorMessage)
            }
            
            Button("Register") {
                register()
            }
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
