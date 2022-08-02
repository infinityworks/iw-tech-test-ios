import Foundation

struct Authority: Codable, Hashable {
    
    var id: Int
    var name: String
    
    public init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "LocalAuthorityId"
        case name = "Name"
    }
}

struct AuthoritiesResponse: Codable {
    var authorities: [Authority]
}
