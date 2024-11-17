//
//  MovieModelViewTests.swift
//  Top10 MoviesTests
//
//  Created by Arpit Dongre on 13/11/24.
//

import XCTest

@testable import Top10_Movies

@MainActor
final class MovieListViewModelTests: XCTestCase {

    var viewModel: MovieListViewModel!
    var mockAPIService: MockMoviesAPIService!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        mockAPIService = MockMoviesAPIService()
        viewModel = MovieListViewModel(moviesAPIService: mockAPIService)
    }

    override func tearDownWithError() throws {
        viewModel = nil
        mockAPIService = nil
        try super.tearDownWithError()
    }
    
    func testInitialState() {
        XCTAssertEqual(viewModel.state, .loading)
        XCTAssertTrue(viewModel.movies.isEmpty)
    }
    
    func testGetPopularMovies_successState() async {
        let mockMovies = [
            MovieAPIResponse(
                id: 123321,
                posterPath: "jkadsbnkn",
                title: "Transformers one"
            )
            ]
        
        mockAPIService.mockMovieListResponse = MovieListAPIResponse(movies: mockMovies)

        await viewModel.getPopularMovies()

        XCTAssertEqual(viewModel.state, .success)
        XCTAssertEqual(viewModel.movies.count, 1)
        XCTAssertEqual(viewModel.movies.first?.title, "Transformers one")
    }
    
    func testFetchMoviesFailure() async {
        mockAPIService.mockError = MoviesAPIServiceError.decodingError

        await viewModel.getPopularMovies()

        XCTAssertEqual(viewModel.state, .error("Failed to decode the data from the server."))
        XCTAssertTrue(viewModel.movies.isEmpty)
    }
}
