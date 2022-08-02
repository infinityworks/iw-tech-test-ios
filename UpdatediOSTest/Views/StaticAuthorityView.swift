//
//  AuthorityDetailView.swift
//  UpdatediOSTest
//
//  Created by gabriele.virbasiute on 18/07/2022.
//

import SwiftUI

struct AuthorityDetailView: View {
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    @State var authority: Authority
    @State private var ratings = [
        Rating(id: "1", value: "55%"),
        Rating(id: "2", value: "55%"),
        Rating(id: "3", value: "55%"),
        Rating(id: "4", value: "55%"),
        Rating(id: "5", value: "55%"),
        Rating(id: "Pass", value: "55%"),
        Rating(id: "Exempt", value: "55%")
    ]

    
    var body: some View {
        NavigationView {
            VStack {
                Text(authority.name + " - Ratings")
                    .padding()
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        Group {
                            Text("Rating")
                            Text("Percentage")
                        }
                        .font(.headline)
                        
                        ForEach(ratings, id: \.self) { rating in
                            Text(rating.id)
                            Text(rating.value)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle(authority.name)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct AuthorityDetailView_Previews: PreviewProvider {
    @State static var authority = Authority(id: 0, name: "")

    static var previews: some View {
        AuthorityDetailView(authority: authority)
    }
}
