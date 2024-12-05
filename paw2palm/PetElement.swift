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
    let ageString: String?
    var birthDate: String?
    let pictureIds: [String]
    
    var description: String{
        "Name: \(name)  \n Breed: \(breedPrimary)\n "
            
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case attributes
        case relationships
    }
    
    enum AttributesKeys: String, CodingKey {
        case name, ageGroup, breedPrimary, descriptionText, pictureThumbnailUrl, adoptionFeeString, sex, sizeGroup, ageString, birthDate
    }
    
    enum RelationshipsKeys: String, CodingKey {
        case pictures
    }
    
    enum PictureDataKeys: String, CodingKey {
        case data
    }

    enum PictureKeys: String, CodingKey {
        case id
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
        ageString = try attributes.decodeIfPresent(String.self, forKey: .ageString)
        birthDate = try attributes.decodeIfPresent(String.self, forKey: .birthDate)
        if let unwrapBirthDate = birthDate {
            self.birthDate = String(unwrapBirthDate.prefix(10))
        }
        
        //so nested, can this be done shorter?
        let relationships = try container.nestedContainer(keyedBy: RelationshipsKeys.self, forKey: .relationships)
        if let pictures = try? relationships.nestedContainer(keyedBy: PictureDataKeys.self, forKey: .pictures),
           let picturesArray = try? pictures.decodeIfPresent([Picture].self, forKey: .data) {
            pictureIds = picturesArray.map {$0.id}
        }
        else {
            pictureIds = []
        }
        
//      pictures follow the format:
//      https://cdn.rescuegroups.org/{orgs.data.id}/pictures/animals/{pet.id[:5}/{pet.id}/{pictures.id}.jpg?
//      ex: name: Stowaway, orgs.data.id = 3077, pet.id = 10013609, picture.id = 56438918, picture2.id = 35712496, picture3.id = 35712498
//      https://cdn.rescuegroups.org/3077/pictures/animals/10013/10013509/56438918.jpg?
//      videos follow the format:
//      https://s3.amazonaws.com/videosroot.rescuegroups.org/s{.orgs.data.id}a{pet.id}m{videos.data.id}.wmv
        
        
    }
}

struct Picture: Decodable {
    let id: String
}

