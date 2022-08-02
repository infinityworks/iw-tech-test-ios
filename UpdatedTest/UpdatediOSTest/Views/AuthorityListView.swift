import SwiftUI

struct AuthorityListView: View {
    @State var authorities: [Authority] = []
    
    var body: some View {
        VStack(alignment: .leading) {
            NavigationView {
                List {
                    ForEach(authorities, id: \.self) { authority in
                        NavigationLink(destination: AuthorityDetailView(authority: authority)) {
                            Text(authority.name)
                        }
                    }
                }
                .navigationTitle("Local Authorities")
                .navigationBarTitleDisplayMode(.inline)
                .task {
                    guard authorities.isEmpty else { return }
                    
                    do {
                        async let authorities = try await FSAClient.getAuthorities()
                        self.authorities = try await authorities
                    } catch {
                        print("Unexpected error: \(error)")
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AuthorityListView()
    }
}
