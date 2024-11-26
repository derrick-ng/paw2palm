//
//  AnimalService.swift
//  paw2palm
//
//  Created by Robin Pilapil on 11/19/24.
//

import Foundation

struct AnimalService{
    private let baseURL = "https://api.rescuegroups.org/v5/public/animals/search/available/"
    private let apiKey = "gg3wS9or"

    func fetchAdoptablePets(onPetsReturned callback:@escaping ([PetElement])-> Void){
        guard let url = URL(string: baseURL) else{
            //TODO: error handling
            return
        }
        
        var request = URLRequest(url: url)
        request.addValue(apiKey, forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request){ data, response, error in
            //TODO: error handling
            guard let data = data else{
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let response = try decoder.decode(PetResponse.self, from: data)
                let pets = response.data
                print(pets)
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
        
    }
}
