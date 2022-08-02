//
//  Establishment.swift
//  UpdatediOSTest
//
//  Created by gabriele.virbasiute on 15/07/2022.
//

import Foundation

struct EstablishmentsResponse: Codable {
    var establishments: [Establishment]
}

public struct Establishment: Codable, Hashable {
    var id: Int
    var rating: String?
    
    public init(id: Int, rating: String) {
        self.id = id
        self.rating = rating
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "FHRSID"
        case rating = "RatingValue"
    }
}
