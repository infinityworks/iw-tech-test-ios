import Foundation

class FSAClient: ObservableObject {
    
    enum AuthoritiesFetcherError: Error {
        case invalidURL
        case missingData
    }
    
    private static let baseUrl = "https://api.ratings.food.gov.uk"
    
    static func getAuthorities() async throws -> [Authority] {
        guard let url = URL(string: baseUrl + "/authorities/basic") else {
            throw AuthoritiesFetcherError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("2", forHTTPHeaderField: "x-api-version")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        
        let authoritiesResult = try JSONDecoder().decode(AuthoritiesResponse.self, from: data)
        return authoritiesResult.authorities
    }
}
