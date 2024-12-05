//
//  PetDetailView.swift
//  paw2palm
//
//  Created by Robin Pilapil on 12/2/24.
//

import SwiftUI

struct PetDetailView: View {
    let pet: PetElement
    
    var body: some View {
        VStack {
            if let thumbnailUrl = pet.pictureThumbnailUrl, let url = URL(string: thumbnailUrl) {
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

            Text("Name: \(pet.name)")
            Text("Breed: \(pet.breedPrimary)")
            Text("ID: \(pet.id)")
            if let birthDate = pet.birthDate {
                Text("Birthday: \(birthDate)")
            }
            if let ageString = pet.ageString {
                Text("Age: \(ageString)")
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
            if !pet.pictureIds.isEmpty {
                Text("Picture Ids: \(pet.pictureIds)")
            }
        }
        .navigationTitle("\(pet.name) Details")
    }
    
}

