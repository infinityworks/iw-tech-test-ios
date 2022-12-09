import Foundation


extension AuthorityListView {
    @MainActor class ViewModel: ObservableObject {
        
        @Published private(set) var authorities: [Authority] = []
        @Published private(set) var isLoading: Bool = false
        @Published var hasError: Bool = false
        
        
        private let networkprovider: NetworkProvider
        
        init(networkprovider: NetworkProvider = NetworkService()) {
            self.networkprovider = networkprovider
        }
        
        func update() async {
            isLoading = true
            defer { isLoading = false }
            
            do {
                let result = try await networkprovider.getAuthorities()
                
                switch result {
                case let .success(data):
                    hasError = false
                    authorities = data
                case .failure:
                    hasError = true
                }
            } catch {
                print("Unexpected error: \(error)")
            }
        }
    }
}
