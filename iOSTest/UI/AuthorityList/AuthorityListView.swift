import SwiftUI

struct AuthorityListView: View {
    @StateObject private var viewModel = AuthorityListViewModel()
    @State private var showingCopyright = false
    
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
                    .toolbar {
                        Button {
                            showingCopyright.toggle()
                        } label: {
                            Image(systemName: "info.circle")
                        }
                    }
                    .alert("Copyright © 2022 Infinity Works, Part of Accenture.", isPresented: $showingCopyright) {
                    } message: {
                        Text("All rights reserved.")
                    }
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

struct AuthorityListView_Previews: PreviewProvider {
    static var previews: some View {
        AuthorityListView()
    }
}
