//
//  MovieDetail.swift
//  Top10 Movies
//
//  Created by Arpit Dongre on 17/11/24.
//

import Foundation

struct MovieDetail: Identifiable, Hashable {
  
    let id: Int
    let title: String
    let originalTitle: String
    let releaseYear: String
    let overview: String
    let originalLanguage: String
    let isMovieRatedR: Bool
    let posterURL: URL?
    let backdropURL: URL?
    let rating: String
    let totalVotes: String
    
    let genres: [Genre]
    let productionCompanies: [ProductionCompany]
    let productionCountries: [ProductionCountry]
    let releaseDate: String
    let runtime: String
    let spokenLanguages: [SpokenLanguage]
}

extension MovieDetail {
    
    init(from apiResponse: MovieDetailAPIResponse) {
        self.id = apiResponse.id
        self.title = apiResponse.title
        self.originalTitle = apiResponse.originalTitle
        self.releaseYear = DateFormatterHelper.getYear(dateString: apiResponse.releaseDate)
        self.overview = apiResponse.overview
        self.originalLanguage = LanguageFormatterHelper.getLanguageName(for: apiResponse.originalLanguage)
        self.isMovieRatedR = apiResponse.isMovieRatedR
        self.posterURL = apiResponse.posterURL
        self.backdropURL = apiResponse.backdropURL
        self.rating = NumberFormatterHelper.formatToOneDecimalPlaces(apiResponse.voteAverage)
        self.totalVotes = String(apiResponse.voteCount)
        
        self.genres = apiResponse.genres
        self.productionCompanies = apiResponse.productionCompanies
        self.productionCountries = apiResponse.productionCountries
        self.releaseDate = DateFormatterHelper.convertDateString(inputDate: apiResponse.releaseDate) 
        self.runtime = TimeFormatterHelper.convertMinutesToHourFormat(minutes: apiResponse.runtime)
        self.spokenLanguages = apiResponse.spokenLanguages
    }
}
