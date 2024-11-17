//
//  MockMoviesAPIService.swift
//  Top10 MoviesTests
//
//  Created by Arpit Dongre on 13/11/24.
//

import Foundation

@testable import Top10_Movies

class MockMoviesAPIService: MoviesAPIService {
    var mockMovieListResponse: MovieListAPIResponse?
    var mockMovieDetailResponse: MovieDetailAPIResponse?
    var mockError: Error?
    
    override func fetchPopularMovies() async throws -> MovieListAPIResponse {
        if let error = mockError {
            throw error
        }
        return mockMovieListResponse ?? MovieListAPIResponse(movies: [])
    }
    
    override func fetchMovieDetail(movieId: Int) async throws -> MovieDetailAPIResponse {
        if let error = mockError {
            throw error
        }
        
        return mockMovieDetailResponse!
    }
}
