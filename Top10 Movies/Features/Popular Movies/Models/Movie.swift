//
//  Movie.swift
//  Top10 Movies
//
//  Created by Arpit Dongre on 13/11/24.
//

import Foundation

struct Movie: Identifiable, Hashable {
  
    let id: Int
    let title: String
    let posterURL: URL?
}

extension Movie {
    
    init(from apiResponse: MovieAPIResponse) {
        self.id = apiResponse.id
        self.title = apiResponse.title
        self.posterURL = apiResponse.posterURL
    }
}
