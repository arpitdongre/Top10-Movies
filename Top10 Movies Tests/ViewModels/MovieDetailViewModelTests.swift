//
//  MovieDetailViewModelTests.swift
//  Top10 MoviesTests
//
//  Created by Arpit Dongre on 17/11/24.
//

import XCTest
@testable import Top10_Movies

@MainActor
class MovieDetailViewModelTests: XCTestCase {
    
    var viewModel: MovieDetailViewModel!
    var mockAPIService: MockMoviesAPIService!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        mockAPIService = MockMoviesAPIService()
        let movieId = 4123
        viewModel = MovieDetailViewModel(movieId: movieId, moviesAPIService: mockAPIService)
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        mockAPIService = nil
        try super.tearDownWithError()
    }
    
    func testInitialState() {
        XCTAssertEqual(viewModel.state, .loading)
    }
    
    func testGetMovieDetail_Success() async {
        
        let mockMovieDetail = MovieDetailAPIResponse(
            adult: false,
            backdropPath: "gadyjhdasdd",
            genres: [],
            id: 2367,
            overview: "bhjdeajhadx qudhewil iqofhcejwwqjhe idcehjaisj",
            originalTitle: "bheqdwjhdsw",
            originalLanguage: "English",
            posterPath: "hbdqswjsjxsa",
            productionCompanies: [],
            productionCountries: [],
            releaseDate: "2024-11-11",
            runtime: 139,
            spokenLanguages: [],
            title: "gyadsjmbh acdhs",
            voteAverage: 7.3,
            voteCount: 1234)
        
        mockAPIService.mockMovieDetailResponse = mockMovieDetail
        
        await viewModel.getMovieDetail()
        
        XCTAssertEqual(viewModel.state, .success)
    }
    
    func testGetMovieDetail_Error() async {
        
        mockAPIService.mockError = MoviesAPIServiceError.decodingError
        
        await viewModel.getMovieDetail()
        
        XCTAssertEqual(viewModel.state, .error("Failed to decode the data from the server."))
    }
}
