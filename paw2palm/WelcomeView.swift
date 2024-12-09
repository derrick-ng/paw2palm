//
//  WelcomeView.swift
//  paw2palm
//
//  Created by Derrick Ng on 12/8/24.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore


// should be in a sep file, AppDelegate
//class AppDelegate: NSObject, UIApplicationDelegate {
//    func application(_ application: UIApplication,
//                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//        FirebaseApp.configure()
//        return true
//    }
//}

struct WelcomeView: View {
//    this basically calls AppDelegate
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    init() {
        initializeFirebase()
        initializeDatabase()
    }
    
    var body: some View {
        VStack{
            TitleComponent()
            Text("Maybe an image here")
            Text("Login")
            Button {
                
            } label: {
                Text("Sign Up")
            }
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
    let db = Firestore.firestore()
    

}
