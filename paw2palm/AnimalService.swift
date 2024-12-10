//
//  AnimalService.swift
//  paw2palm
//
//  Created by Robin Pilapil on 11/19/24.
//

import Foundation

enum PetServiceError: Error{
    case invalidURL, missingData
}
struct AnimalService{
    private let baseURL = "https://api.rescuegroups.org/v5/public/animals/search/available/"
    private let apiKey = "gg3wS9or"

    func fetchAdoptablePets(onPetsReturned callback:@escaping (Result<[PetElement], any Error>)-> Void){
        guard let url = URL(string: baseURL) else{
            callback(.failure(PetServiceError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.addValue(apiKey, forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request){ data, response, error in
            //error is client side error if lost connection
            if let error = error{
                callback(.failure(error))
            }
            
            // error if there is missing dats
            guard let data = data else{
                callback(.failure(PetServiceError.missingData))
                return
            }
            
            
                let decoder = JSONDecoder()
                
            //attempt decoding data of pets 
            do {
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let response = try decoder.decode(PetResponse.self, from: data)
                let pets = response.data
                callback(.success(pets))
                print(pets)
            } catch {
                print("Error decoding JSON: \(error)")
                callback(.failure(error))
            }
        }.resume()
        
    }
}
