//
//  MovieListViewModel.swift
//  Top10 Movies
//
//  Created by Arpit Dongre on 12/11/24.
//

import Foundation

@MainActor
class MovieListViewModel: ObservableObject {
    
    @Published var movies: [Movie] = []
    @Published var state: MovieListState = .loading
    
    private let moviesAPIService: MoviesAPIService
    
    init(moviesAPIService: MoviesAPIService = MoviesAPIService()) {
        self.moviesAPIService = moviesAPIService
    }
    
    func getPopularMovies() async {
        state = .loading
        
        do {
            let apiResponse = try await moviesAPIService.fetchPopularMovies()
            
            self.movies = apiResponse.movies.map { movieAPIResponse in
                Movie.init(from: movieAPIResponse)
            }
            self.state = .success
        }
        catch {
            self.state = .error(error.localizedDescription)
        }
    }
}
