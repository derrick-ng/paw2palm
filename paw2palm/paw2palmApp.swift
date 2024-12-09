//
//  paw2palmApp.swift
//  paw2palm
//
//  Created by Robin Pilapil on 11/11/24.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore

@main
struct paw2palmApp: App {
    init() {
        initializeFirebase()
        initializeDatabase()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

func initializeFirebase() {
    //maybe this
    //https://firebase.google.com/docs/firestore/quickstart
    
    if FirebaseApp.app() == nil {
        FirebaseApp.configure()
        print("Firebase initialized, success")
    }
}

func initializeDatabase() {
//    let db = Firestore.firestore()
    

}
