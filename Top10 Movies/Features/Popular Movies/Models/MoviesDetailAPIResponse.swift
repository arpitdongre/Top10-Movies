//
//  MovieDetail.swift
//  Top10 Movies
//
//  Created by Arpit Dongre on 17/11/24.
//

import Foundation

// MARK: - MovieDetail
struct MovieDetailAPIResponse: Codable {
    let adult: Bool
    let backdropPath: String
    let genres: [Genre]
    let id: Int
    let overview: String
    var originalTitle: String
    let originalLanguage: String
    let posterPath: String
    let productionCompanies: [ProductionCompany]
    let productionCountries: [ProductionCountry]
    let releaseDate: String
    let runtime: Int
    let spokenLanguages: [SpokenLanguage]
    let title: String
    let voteAverage: Double
    let voteCount: Int
    
    var posterURL: URL? {
        get {
            let baseURL = "https://image.tmdb.org/t/p/"
            let fileSize = "w300"
            
            return URL(string: baseURL + fileSize + posterPath)
        }
    }
    
    var backdropURL: URL? {
        get {
            let baseURL = "https://image.tmdb.org/t/p/"
            let fileSize = "original"
            
            return URL(string: baseURL + fileSize + backdropPath)
        }
    }
    
    var isMovieRatedR: Bool {
        get {
            if adult {
                return true
            }
            return false
        }
    }

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genres, id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case runtime
        case spokenLanguages = "spoken_languages"
        case title
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

// MARK: - Genre
struct Genre: Codable, Hashable {
    let id: Int
    let name: String
}

// MARK: - ProductionCompany
struct ProductionCompany: Codable, Hashable, Identifiable {
    let id: Int
    let logoPath: String?
    let name, originCountry: String
    
    var logoURL: URL? {
        get {
            let baseURL = "https://image.tmdb.org/t/p/" 
            let fileSize = "w200"
            
            return URL(string: baseURL + fileSize + (logoPath ?? ""))
        }
    }

    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}

// MARK: - ProductionCountry
struct ProductionCountry: Codable, Hashable {
    let iso3166_1, name: String

    enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case name
    }
}

// MARK: - SpokenLanguage
struct SpokenLanguage: Codable, Hashable {
    let englishName, iso639_1, name: String

    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso639_1 = "iso_639_1"
        case name
    }
}
