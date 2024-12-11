//
//  SavedPetView.swift
//  paw2palm
//
//  Created by Robin Pilapil on 12/11/24.
//

import SwiftUI


struct SavedPetView: View {
    @Binding
    var savedPets: [PetElement]
    var onNavigationPressed: (PetElement) -> Void
    var body: some View {
       
        VStack {
            List {
                ForEach(savedPets, id: \.id) { petElement in
                    VStack(alignment: .leading, spacing: 10) {
                        if let thumbnailUrl = petElement.pictureThumbnailUrl, let url = URL(string: thumbnailUrl) {
                            AsyncImage(url: url) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 330, height: 330)
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
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
                            .background(Color.niceBlue)
                            .cornerRadius(8)
                        
                    }
                    .padding(.vertical, 5)
                }
            }
        }
    }
}
