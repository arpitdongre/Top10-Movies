//
//  MovieDetailViewModel.swift
//  Top10 Movies
//
//  Created by Arpit Dongre on 17/11/24.
//

import Foundation

@MainActor
class MovieDetailViewModel: ObservableObject {
    
    @Published var movieDetail: MovieDetail? = nil
    @Published var state: MovieDetailState = .loading
    
    private let movieId: Int
    private let moviesAPIService: MoviesAPIService
    
    init(movieId: Int, moviesAPIService: MoviesAPIService = MoviesAPIService()) {
        self.movieId = movieId
        self.moviesAPIService = moviesAPIService
    }
    
    func getMovieDetail() async {
        state = .loading
        
        do {
            let movieDetailAPIResponse = try await moviesAPIService.fetchMovieDetail(movieId: movieId)
            
            self.movieDetail = MovieDetail.init(from: movieDetailAPIResponse)
            
            self.state = .success
        }
        catch {
            self.state = .error(error.localizedDescription)
        }
    }
}
