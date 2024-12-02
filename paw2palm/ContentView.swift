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
        NavigationStack {
            //https://developer.apple.com/documentation/swiftui/navigationstack
            //why is there no VStack here??
            List {
                ForEach(pets, id: \.id){ petElement in
                    VStack {
                        Text(petElement.description)
                        NavigationLink(destination: PetDetailView(pet: petElement)) {
                            Text("Details")
                        }
                    }
                }
            }
            .navigationTitle("Adoptale Pets")
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

struct PetDetailView: View {
    let pet: PetElement
    
    var body: some View {
        VStack {
            Text("Name: \(pet.name)")
            Text("Breed: \(pet.breedPrimary)")
            if let birthDate = pet.birthDate {
                Text("Birthday: \(birthDate)")
            }
            if let sex = pet.sex {
                Text("Sex: \(sex)")
            }
            if let sizeGroup = pet.sizeGroup {
                Text("Size Group: \(sizeGroup)")
            }
            if let adoptionFee = pet.adoptionFeeString {
                Text("Adoption Fee: \(adoptionFee)")
            }
        }
        .navigationTitle("\(pet.name) Details")
    }
    
}

#Preview {
    ContentView()
}
