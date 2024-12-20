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
        ScrollView{
            VStack(alignment: .center) {
                if let thumbnailUrl = pet.pictureThumbnailUrl, let url = URL(string: thumbnailUrl) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 350, height: 350)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    } placeholder: {
                        ProgressView()
                            .frame(width: 350, height: 350)
                    }
                } else {
                    Text("No Image Available")
                        .frame(width: 200, height: 200)
                        .background(Color.gray.opacity(0.3))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                
                Text(pet.name)
                    .font(.title2)
                    .fontWeight(.bold)
               
                
                VStack{
                    Text("Breed: \(pet.breedPrimary)")
                           
                    Text("ID: \(pet.id)")
                    if let birthDate = pet.birthDate {
                        Text("Birthday: \(birthDate)")
                    }
                    if let cityState = pet.cityState{
                        Text("City, State: \(cityState)")
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
                    
                }.font(.headline)
                .foregroundStyle(.secondary)
                    
                if let descriptionText = pet.descriptionText{
                    Text("Description:\n\(descriptionText)")
                        
                        .padding()
                        
                        
                }
                Spacer()
                
                //            if !pet.allPictureUrls.isEmpty {
                //                Text("urls: \(pet.allPictureUrls)")
                //            }
                if !pet.allPictureUrls.isEmpty {
                    VStack {
                        Spacer()
                        Text("Additional Photos")
                            .font(.title)
                            .padding(.bottom, 10)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                ForEach(pet.allPictureUrls, id: \.self) { url in
                                    AsyncImage(url: URL(string: url)) { image in
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 300, height: 300)
                                            .clipShape(RoundedRectangle(cornerRadius: 15))
                                            .shadow(radius: 5)
                                    } placeholder: {
                                        ProgressView()
                                            .frame(width: 300, height: 300)
                                    }
                                }
                            }
                            .padding()
                        }
                    }
                }
                
            }
        }
        .navigationTitle("\(pet.name) Details")
    }
    
}

