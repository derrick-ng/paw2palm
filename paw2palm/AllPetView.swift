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
                
                Text(petElement.description)
                //use navigation stack and navigation destination instead
                
                
                Button("Details"){
                    onNavigationPressed(petElement)
                }
                
            }
                
            
        }
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


