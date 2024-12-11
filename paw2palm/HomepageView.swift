//
//  HomepageView.swift
//  paw2palm
//
//  Created by Robin Pilapil on 12/6/24.
//

import SwiftUI

struct HomepageView: View {
    
    @Binding
    var userLoggedIn: Bool
    
    @Binding
    var email: String
    
    @State
    var path = [PetElement]()
    
    @State
    var selectedTab: Int = 1
    
    @Binding
    var savedPets: [PetElement]
    
    var body: some View {
        TitleComponent()
        TabView(selection: $selectedTab){
            NavigationStack(path: $path){
                AllPetView(onNavigationPressed: {petElement in
                    path.append(petElement)
                }, savedPets: $savedPets).navigationDestination(for: PetElement.self){ petElement in
                    PetDetailView(pet: petElement)
                }
                    
            }
                .navigationTitle("Adoptable Pets")
                    .tabItem {
                        Image(systemName: "dog.fill")
                        Text("Adoptable Pets")
                    }.tag(1)
            SavedPetView(savedPets: $savedPets, onNavigationPressed: {petElement in
                path.append(petElement)}
            )
                .navigationTitle("Saved Pets!")
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Saved")
                }.tag(2)
            ProfileView(userLoggedIn: $userLoggedIn, email: $email)
                .navigationTitle("Profile")
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }.tag(3)
        }
         
    }
}
