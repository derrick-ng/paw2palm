//
//  AllPetView.swift
//  paw2palm
//
//  Created by Robin Pilapil on 12/5/24.
//

import SwiftUI

struct AllPetView: View {
    
    var onNavigationPressed: (PetElement) -> Void
    
    let service = AnimalService()
    
    @State
    var pets: [PetElement] = []
    
    var body: some View {
        VStack{
            List {
                ForEach(pets, id: \.id){ petElement in
                    if let thumbnailUrl = petElement.pictureThumbnailUrl, let url = URL(string: thumbnailUrl) {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 200, height: 200)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                
                        } placeholder: {
                            ProgressView()
                                .frame(width: 200, height: 200)
                        }
                    } else {
                        Text("No Image Available")
                            .frame(width: 200, height: 200)
                            .background(Color.gray.opacity(0.3))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    
                    Text(petElement.name)
                        .font(.title2)
                        .fontWeight(.bold)
                    Text("Breed: \(petElement.breedPrimary)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Button("Details"){
                        onNavigationPressed(petElement)
                    }.font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                    
                }
                
                
            }
        }.background(Color.blue)
        .onAppear(perform: {
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


