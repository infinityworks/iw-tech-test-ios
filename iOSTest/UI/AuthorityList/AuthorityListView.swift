import SwiftUI

struct AuthorityListView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            NavigationView {
                if viewModel.loading {
                    ProgressView()
                } else if viewModel.error {
                    Text("Network Error")
                } else {
                    List {
                        ForEach(viewModel.authorities, id: \.self) { authority in
                            NavigationLink(destination: AuthorityDetailView(authority: authority)) {
                                Text(authority.name)
                            }
                        }
                    }
                    .navigationTitle("Local Authorities")
                    .navigationBarTitleDisplayMode(.inline)
                }
            }.task {
                await viewModel.update()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AuthorityListView()
    }
}
