//
//  model.swift
//  gridsearch
//
//  Created by 亞萱林 on 08/03/2021.
//

import SwiftUI

struct RSS: Decodable {
    let feed: Feed
}

struct Feed: Decodable {
    let results: [Result]
}

struct Result: Decodable, Hashable {
    let artistName, name, artworkUrl100: String
    let releaseDate: String?
}
