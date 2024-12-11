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


struct PetElement: Decodable, Identifiable, CustomStringConvertible, Hashable {
    let id: String
    let shortId: String
    let name: String
    let breedPrimary: String
    let pictureThumbnailUrl: String?
    let adoptionFeeString: String?
    let sex: String?
    let sizeGroup: String?
    let ageString: String?
    var birthDate: String?
    let cityState: String?
    let pictureIds: [String]
    let orgId: [String]
    let descriptionText: String?
    var allPictureUrls: [String] = []
    
    var description: String{
        "Name: \(name)\nBreed: \(breedPrimary)\n"
            
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case attributes
        case relationships
    }
    
    enum AttributesKeys: String, CodingKey {
        case name, ageGroup, breedPrimary, descriptionText, pictureThumbnailUrl, adoptionFeeString, sex, sizeGroup, ageString, birthDate, cityState
    }
    
    enum RelationshipsKeys: String, CodingKey {
        case pictures, orgs
    }
    
    enum PictureDataKeys: String, CodingKey {
        case data
    }
    
    //may be redundant?? maybe can just use PictureDataKeys
    enum OrgDataKeys: String, CodingKey {
        case data
    }

    enum PictureKeys: String, CodingKey {
        case id
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        shortId = String(id.prefix(5))
        
        // go through attributes
        let attributes = try container.nestedContainer(keyedBy: AttributesKeys.self, forKey: .attributes)
        name = try attributes.decode(String.self, forKey: .name)
        
        breedPrimary = try attributes.decode(String.self, forKey: .breedPrimary)
        pictureThumbnailUrl = try attributes.decodeIfPresent(String.self, forKey: .pictureThumbnailUrl)
        adoptionFeeString = try attributes.decodeIfPresent(String.self, forKey: .adoptionFeeString)
        sex = try attributes.decodeIfPresent(String.self, forKey: .sex)
        sizeGroup = try attributes.decodeIfPresent(String.self, forKey: .sizeGroup)
        ageString = try attributes.decodeIfPresent(String.self, forKey: .ageString)
        birthDate = try attributes.decodeIfPresent(String.self, forKey: .birthDate)
        descriptionText = try attributes.decodeIfPresent(String.self, forKey: .descriptionText)
        cityState =  try attributes.decodeIfPresent(String.self, forKey: .cityState)
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
        
        //could maybe rewrite so it isnt stored as an array, should always have only 1 value for org id
        if let orgs = try? relationships.nestedContainer(keyedBy: OrgDataKeys.self, forKey: .orgs),
           let orgsArray = try? orgs.decodeIfPresent([Org].self, forKey: .data) {
            orgId = orgsArray.map {$0.id}
        }
        else {
            orgId = []
        }
        
        for i in 0..<pictureIds.count {
            let pictureUrl = "https://cdn.rescuegroups.org/\(orgId[0])/pictures/animals/\(shortId)/\(id)/\(pictureIds[i]).jpg?"
            allPictureUrls.append(pictureUrl)
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

struct Org: Decodable {
    let id: String
}
//func createPictureUrls(pictureIdArray: Picture, OrgId: Org, shortId: String, id: String) {
//    for i in range..<pictureIdArray.id.count {
//
//    }
//}
