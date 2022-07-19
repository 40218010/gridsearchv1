//
//  viewmodel.swift
//  gridsearch
//
//  Created by 亞萱林 on 08/03/2021.
//

import SwiftUI

class GridViewModel: ObservableObject {
    
    @Published var items = 0..<4
    @Published var results = [Result]()
    
    init() {
        //json decoding simulation
        /* Timer.scheduledTimer(withTimeInterval: 2,repeats: false) { (_) in
         self.items = 0..<10
         
         } */
        
        guard let url = URL(string:
                                "https://rss.applemarketingtools.com/api/v2/gb/apps/top-free/50/apps.json") else { return }
        URLSession.shared.dataTask(with: url) { (data,resp,err) in
            //check resp status and err
            guard let data = data else { return }
            do {
                let rss = try JSONDecoder().decode(RSS.self, from: data)
                print(rss)
                
                DispatchQueue.main.async {
                    self.results = rss.feed.results
                }
                
            } catch {
                print("Failed to decode: \(error)")
            }
            
        }.resume()
        
    }
    
}

