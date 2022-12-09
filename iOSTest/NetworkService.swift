import Foundation


protocol NetworkProvider {
    func getAuthorities() async throws -> AuthoritiesResponse
}

class NetworkService: NetworkProvider {
    
    private static let baseUrl = "https://api.ratings.food.gov.uk"
    
    func getAuthorities() async throws -> AuthoritiesResponse {
        guard let url = URL(string: NetworkService.baseUrl + "/authorities/basic") else {
            throw AuthoritiesFetcherError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("2", forHTTPHeaderField: "x-api-version")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        
        let authoritiesResult = try JSONDecoder().decode(AuthoritiesResponse.self, from: data)
        return authoritiesResult
    }
}

extension NetworkService {
    enum AuthoritiesFetcherError: Error {
        case invalidURL
        case unexpected(error: Error)
    }
}


