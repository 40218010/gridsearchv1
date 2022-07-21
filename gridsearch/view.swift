//
//  search.swift
//  gridsearch
//
//  Created by 亞萱林 on 11/03/2021.
//

import SwiftUI
import Kingfisher

struct searchView: View {
    @State var searchText = ""
    @State var isSearching = false
    @ObservedObject var vm = GridViewModel()
    private let gridItem = [
        GridItem(.flexible(minimum: 60, maximum: 200), alignment: .top),
        GridItem(.flexible(minimum: 60, maximum: 200),alignment: .top),
        GridItem(.flexible(minimum: 60, maximum: 200),alignment: .top),
        GridItem(.flexible(minimum: 60, maximum: 200),alignment: .top)
    ]
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {

                    SearchBar(searchText: $searchText, isSearching: $isSearching)
                    
                    VStack(spacing: 20) {
                        LazyVGrid (columns: gridItem,
                                   content: {
                                    ForEach((vm.results).filter({ "\($0.name)".contains(searchText) || searchText.isEmpty}), id: \.self) { app in
                                        
                                        VStack(alignment: .leading) {
                                            
                                            KFImage(URL(string: app.artworkUrl100))
                                                .resizable()
                                                .scaledToFit()
                                                .cornerRadius(20)
                                            
                                            Text(app.name)
                                                .font(.system(size: 10,weight:.semibold))
                                            Text(app.releaseDate ?? "")
                                                .font(.system(size:12 ,weight: .regular))
                                            Text(app.artistName)
                                                .font(.system(size:12 ,weight: .regular))
                                                .lineLimit(3)
                                            
                                        }
                                        
                                    }
                                    
                                   }).padding(.horizontal)
                    }
                    
                    //  Divider()
                    //      .background(Color(.systemGray3))
                    //      .padding(.leading)
                    
                    
                }
                
            }.navigationBarTitle("Grid Search")
        }
        
    }
}

struct searchView_Previews: PreviewProvider {
    static var previews: some View {
        searchView()
    }
}

struct SearchBar: View {
    @Binding var searchText: String
    @Binding var isSearching: Bool
    
    var body: some View {
        HStack {
            HStack {
                TextField("search terms here", text: $searchText)
            }
            .padding(.leading,20)
            .padding()
            .background(Color(.systemGray5))
            .cornerRadius(10)
            .padding(.horizontal)
            .onTapGesture(perform: {
                isSearching = true
            })
            .overlay(
                HStack{
                    Image(systemName: "magnifyingglass")
                    Spacer()
                    if isSearching {
                        Button(action: {
                            searchText = ""
                        }, label: {
                            Image(systemName: "xmark.circle")
                                .padding(.vertical)
                        })
                    }
                }
                .padding(.horizontal, 30)
                .foregroundColor(.gray)
            )
            if isSearching {
                
                Button(action: {
                    isSearching = false
                    searchText = ""
                    
                    //dismiss keyboard
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }, label: {
                    Text("Cancel")
                        .padding(.trailing)
                        .padding(.leading, -10)
                })
                .transition(.move(edge: .trailing))
                .animation(.default)
            }
            
        }
    }
}
