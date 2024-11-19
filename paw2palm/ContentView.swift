//
//  ContentView.swift
//  paw2palm
//
//  Created by Robin Pilapil on 11/11/24.
//

import SwiftUI


struct ContentView: View {
    
    //TODO: make animal service file
    let service = AnimalService()
    
    var body: some View {
        VStack {
            Text("Animals Available Text: \n")
        }
        .padding()
        .onAppear(perform: {
            //TODO: make onPetsReturned() and PetElement struct
            service.fetchAdoptablePets(onPetsReturned: { (pets: String) in
                print(pets)
            })
        })
    }
}

#Preview {
    ContentView()
}
