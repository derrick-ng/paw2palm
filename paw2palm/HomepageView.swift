//
//  HomepageView.swift
//  paw2palm
//
//  Created by Robin Pilapil on 12/6/24.
//

import SwiftUI

struct HomepageView: View {
    
    @State
    var path = [PetElement]()
    
    @State
    var selectedTab: Int = 1
    
    var body: some View {
        
        TabView(selection: $selectedTab){
            NavigationStack(path: $path){
                AllPetView(onNavigationPressed: {petElement in
                    path.append(petElement)
                }).navigationDestination(for: PetElement.self){ petElement in
                    PetDetailView(pet: petElement)
                }
                    
            }
            .navigationTitle("Adoptable Pets")
                .tabItem {
                    Image(systemName: "dog.fill")
                    Text("Adoptable Pets")
                }.tag(1)
            
            ProfileView()
                .navigationTitle("Profile")
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }.tag(2)
        }
         
    }
}
