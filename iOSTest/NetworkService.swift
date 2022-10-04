import Foundation


protocol NetworkProvider {
    func getAuthorities() async throws -> Result<[Authority], Error>
}

class NetworkService: NetworkProvider {
    
    enum AuthoritiesFetcherError: Error {
        case invalidURL
        case missingData
    }
    
    private static let baseUrl = "https://api.ratings.food.gov.uk"
    
    func getAuthorities() async throws -> Result<[Authority], Error> {
        guard let url = URL(string: NetworkService.baseUrl + "/authorities/basic") else {
            return .failure(AuthoritiesFetcherError.invalidURL)
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("2", forHTTPHeaderField: "x-api-version")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        
        let authoritiesResult = try JSONDecoder().decode(AuthoritiesResponse.self, from: data)
        return .success(authoritiesResult.authorities)
    }
}
