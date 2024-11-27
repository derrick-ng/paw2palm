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
    
    @State
    var pets: [PetElement] = []
    
    var body: some View {
        VStack {
            List{
                ForEach(pets, id: \.id){ petElement in
                    Text(petElement.description)
                }
            }
        }
        .padding()
        .onAppear(perform: {
            //TODO: make onPetsReturned() and PetElement struct
            service.fetchAdoptablePets(onPetsReturned: { result in
                switch result {
                case .success(let pets):
                    self.pets = pets
                case .failure(let error):
                    print(error)
                }
        
                print(result)
            })
        })
    }
}

#Preview {
    ContentView()
}
