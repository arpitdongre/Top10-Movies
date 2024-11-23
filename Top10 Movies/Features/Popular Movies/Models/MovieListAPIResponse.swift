//
//  MoviesList.swift
//  Top10 Movies
//
//  Created by Arpit Dongre on 12/11/24.
//

import Foundation

// MARK: - MovieListAPIResponse
struct MovieListAPIResponse: Codable {
  
    let movies: [MovieAPIResponse]

    enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}

// MARK: - MovieAPIResponse
struct MovieAPIResponse: Codable, Identifiable, Hashable {
   
    let id: Int
    let posterPath, title: String
    
    var posterURL: URL? {
        get {
            let baseURL = "https://image.tmdb.org/t/p/"
            let fileSize = "w500"
            
            return URL(string: baseURL + fileSize + posterPath)
        }
    }

    enum CodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
        case title
    }
}
