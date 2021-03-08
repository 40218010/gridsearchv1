//
//  ContentView.swift
//  gridsearch
//
//  Created by 亞萱林 on 01/03/2021.
//

import SwiftUI
import Kingfisher

struct ContentView: View {
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
                LazyVGrid (columns: gridItem,
                           content: {
                            ForEach(vm.results, id: \.self) { app in
                                
                                VStack(alignment: .leading) {
                                    
                                    KFImage(URL(string: app.artworkUrl100))
                                        .resizable()
                                        .scaledToFit()
                                        .cornerRadius(20)
                                    
                                    
                                    Text(app.name)
                                        .font(.system(size: 10,weight:.semibold))
                                    Text(app.releaseDate)
                                        .font(.system(size:12 ,weight: .regular))
                                    Text(app.copyright)
                                        .font(.system(size:12 ,weight: .regular))
                                    
                                    
                                }
                                
                            }
                            
                            
                           }).padding(.horizontal)
            }
            .navigationTitle("20210301")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
