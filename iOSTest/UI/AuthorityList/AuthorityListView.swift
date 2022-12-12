import SwiftUI

struct AuthorityListView: View {
    @StateObject private var viewModel = AuthorityListViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            NavigationView {
                if viewModel.isLoading {
                    ProgressView()
                } else if viewModel.hasError {
                    networkErrorView
                } else {
                    List {
                        ForEach(viewModel.authorities, id: \.self) { authority in
                            NavigationLink(destination: AuthorityDetailView(authority: authority)) {
                                Text(authority.name)
                            }
                        }
                    }
                    .navigationTitle("Local Authorities")
                }
            }.task {
                await viewModel.update()
            }
        }
    }
    
    var networkErrorView: some View {
        VStack {
            Image(systemName: "wifi.exclamationmark")
            Text("Network Error")
                .font(.headline)
            Text("Something went wrong...")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AuthorityListView()
    }
}
