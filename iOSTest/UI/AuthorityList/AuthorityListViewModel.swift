import Foundation


extension AuthorityListView {
    @MainActor class ViewModel: ObservableObject {
        
        @Published var loading: Bool = true
        @Published var authorities: [Authority] = []
        @Published var error: Bool = false
        
        
        private let networkprovider: NetworkProvider
        
        init(networkprovider: NetworkProvider = NetworkService()) {
            self.networkprovider = networkprovider
        }
        
        func update() async {
            do {
                let result = try await networkprovider.getAuthorities()
                
                switch result {
                case let .success(data):
                    error = false
                    loading = false
                    authorities = data
                case .failure:
                    loading = false
                    error = true
                }
            } catch {
                print("Unexpected error: \(error)")
            }
        }
    }
}
