//
//  PetElement.swift
//  paw2palm
//
//  Created by Robin Pilapil on 11/25/24.
//

import Foundation

struct PetResponse: Decodable {
    let data: [PetElement]
}

struct PetElement: Decodable, Identifiable, CustomStringConvertible {
    let id: String
    let name: String
    let breedPrimary: String
    let pictureThumbnailUrl: String?
    let adoptionFeeString: String?
    let sex: String?
    let sizeGroup: String?
    let birthDate: String?
    
    var description: String{
        "\nPetElement: \n Name: \(name)  \n Breed: \(breedPrimary)\n "
            
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case attributes
    }
    
    enum AttributesKeys: String, CodingKey {
        case name, ageGroup, breedPrimary, descriptionText, pictureThumbnailUrl, adoptionFeeString, sex, sizeGroup, birthDate
    }
    

    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        
        //parse through attributes
        let attributes = try container.nestedContainer(keyedBy: AttributesKeys.self, forKey: .attributes)
        name = try attributes.decode(String.self, forKey: .name)
        
        breedPrimary = try attributes.decode(String.self, forKey: .breedPrimary)
        pictureThumbnailUrl = try attributes.decodeIfPresent(String.self, forKey: .pictureThumbnailUrl)
        adoptionFeeString = try attributes.decodeIfPresent(String.self, forKey: .adoptionFeeString)
        sex = try attributes.decodeIfPresent(String.self, forKey: .sex)
        sizeGroup = try attributes.decodeIfPresent(String.self, forKey: .sizeGroup)
        birthDate = try attributes.decodeIfPresent(String.self, forKey: .birthDate)
        
    }
}


