import Foundation


@MainActor
final class AuthorityListViewModel: ObservableObject {
    @Published private(set) var authorities: [Authority] = []
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var error: NetworkService.AuthoritiesFetcherError?
    @Published var hasError: Bool = false
    
    private let networkProvider: NetworkProvider
    
    init(networkProvider: NetworkProvider = NetworkService()) {
        self.networkProvider = networkProvider
    }
    
    func update() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let response = try await networkProvider.getAuthorities()
            self.authorities = response.authorities
        } catch {
            self.hasError = true
            if let networkingError = error as? NetworkService.AuthoritiesFetcherError {
                self.error = networkingError
            } else {
                self.error = .unexpected(error: error)
            }
        }
    }
}
