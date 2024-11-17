//
//  MovieListView.swift
//  Top10 Movies
//
//  Created by Arpit Dongre on 12/11/24.
//

import Foundation
import SwiftUI

enum MovieListState: Equatable {
    case loading
    case success
    case error(String)
}

struct MovieListView: View {
    
    @StateObject private var viewModel = MovieListViewModel()
    @State private var path = NavigationPath()
    
    var body: some View {
        
        NavigationStack(path: $path) {
            
            VStack {
                
                switch viewModel.state {
                case .loading:
                    ProgressView("Loading movies...")
                        .padding()
                    
                case .error(let errorMessage):
                    ErrorView(errorMessage: errorMessage)
               
                case .success:
                    let movies = Array(viewModel.movies.prefix(10))
                    MovieListContentView(movies: movies, path: $path)
                }
            }
            .navigationTitle("Popular Movies")
            .navigationBarTitleDisplayMode(.inline)
        }
        .task {
            await viewModel.getPopularMovies()
        }
    }
    
    private struct ErrorView: View {
        
        let errorMessage: String
        
        var body: some View {
            VStack {
                Image(systemName: "xmark.icloud.fill")
                    .resizable()
                    .foregroundStyle(.red)
                    .frame(width: 40, height: 30)
                    .aspectRatio(contentMode: .fit)
                Text("Error: \(errorMessage)")
                    .bold()
                    .foregroundStyle(.secondary)
                    .padding(10)
            }
        }
    }
    
    private struct MovieListContentView: View {
        
        let movies: [Movie]
        
        @Binding var path: NavigationPath
        
        var body: some View {
            
            List {
                ForEach(movies) {
                    movie in
                    VStack(alignment: .center) {
                        
                        if let posterURL = movie.posterURL {
                            AsyncCachedImage(url: posterURL,
                                             placeholder: AnyView(
                                                ProgressView("Loading...").progressViewStyle(CircularProgressViewStyle(tint: .secondary))
                                                .frame(width: 200)
                                             )
                            )
                            .scaledToFit()
                            .frame(height: 400)
                            .cornerRadius(8.0)
                            .shadow(color: .gray, radius: 2, x: 0, y: 2)
                            
                            Text(movie.title)
                                .bold()
                            
                            Divider()
                        }
                    }
                    .listRowSeparator(.hidden)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .onTapGesture {
                        path.append(movie)
                    }
                }
            }
            .padding(0)
            .listStyle(.plain)
            .navigationDestination(for: Movie.self) {
                movie in
                MovieDetailView(movieId: movie.id)
            }
        }
    }
}

#Preview {
    MovieListView()
}
