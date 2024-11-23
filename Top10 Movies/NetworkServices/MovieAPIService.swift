//
//  MoviesAPIService.swift
//  Top10 Movies
//
//  Created by Arpit Dongre on 12/11/24.
//

import Foundation

enum AuthConfig {
    static let token = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhZTIyNDAwMjBkZmI3M2E0ODE5NTM1MTg1YjNhYjY1ZiIsIm5iZiI6MTczMTM4NzEyOC41MzAyNTQ0LCJzdWIiOiI2NzMyZGRkMjYwN2U4YWEyMGVmNjgzNTgiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.76_OMN8E_bmGqjURvemYJh9_lV30g2MdcmXe5IruhDo"
}

enum MoviesAPIServiceError: LocalizedError {
    
    case invalidURL
    case networkError(Error)
    case decodingError
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL provided is invalid."
        case .networkError(let error):
            return "Network error occurred: \(error.localizedDescription)"
        case .decodingError:
            return "Failed to decode the data from the server."
        }
    }
}

class MoviesAPIService {
    
    func fetchPopularMovies() async throws -> MovieListAPIResponse {
        
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular") else {
            throw MoviesAPIServiceError.invalidURL
        }
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "page", value: "1"),
        ]
        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
            "accept": "application/json",
            "Authorization": AuthConfig.token
        ]
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            
            do {
                let apiResponse = try JSONDecoder().decode(MovieListAPIResponse.self, from: data)
                return apiResponse
            }
            catch {
                throw MoviesAPIServiceError.decodingError
            }
        } catch {
            throw MoviesAPIServiceError.networkError(error)
        }
    }
    
    func fetchMovieDetail(movieId: Int) async throws -> MovieDetailAPIResponse {
        
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieId))") else {
            throw MoviesAPIServiceError.invalidURL
        }
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
          URLQueryItem(name: "language", value: "en-US"),
        ]
        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems

        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
          "accept": "application/json",
          "Authorization": AuthConfig.token
        ]

        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            
            do {
                let apiResponse = try JSONDecoder().decode(MovieDetailAPIResponse.self, from: data)
                return apiResponse
            }
            catch {
                throw MoviesAPIServiceError.decodingError
            }
        } catch {
            throw MoviesAPIServiceError.networkError(error)
        }
    }
}
