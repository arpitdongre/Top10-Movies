//
//  MovieDetailView.swift
//  Top10 Movies
//
//  Created by Arpit Dongre on 12/11/24.
//

import SwiftUI

enum MovieDetailState: Equatable {
    case loading
    case success
    case error(String)
}

struct MovieDetailView: View {
    
    @StateObject private var viewModel: MovieDetailViewModel
    
    init(movieId: Int) {
        _viewModel = StateObject(wrappedValue: MovieDetailViewModel(movieId: movieId))
    }
    
    var body: some View {
        VStack {
            
            switch viewModel.state {
            case .loading:
                ProgressView("Loading movies...")
                    .padding()
                
            case .error(let errorMessage):
                ErrorView(errorMessage: errorMessage)
                
            case .success:
                if let movieDetail = viewModel.movieDetail {
                    MovieDetailContentView(movieDetail: movieDetail)
                }
            }
        }
        .task {
            await viewModel.getMovieDetail()
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
    
    private struct MovieDetailContentView: View {
        
        var movieDetail: MovieDetail
        
        var body: some View {
            ScrollView {
                MovieBackdropView(backdropURL: movieDetail.backdropURL)
                MoviePosterView(movieDetail: movieDetail)
                MovieDetailsSection(movieDetail: movieDetail)
            }
            .navigationTitle(movieDetail.title)
        }
    }
    
    private struct MovieBackdropView: View {
        let backdropURL: URL?
        
        var body: some View {
            if let url = backdropURL {
                AsyncCachedImage(url: url,
                                 placeholder: AnyView(ProgressView("Loading...").progressViewStyle(CircularProgressViewStyle(tint: .secondary))
                                    .frame(width: 200)
                                 ),
                                 errorImage: AnyView(Image(systemName: "xmark.icloud.fill")
                                    .resizable()
                                    .foregroundColor(.blue))
                )
                .frame(height: 300)
                .scaledToFit()
            }
        }
    }
    
    private struct MoviePosterView: View {
        let movieDetail: MovieDetail
        
        var body: some View {
                HStack {
                    if let url = movieDetail.posterURL {
                        AsyncCachedImage(url: url)
                            .frame(width: 200, height: 300)
                            .scaledToFit()
                            .cornerRadius(8.0)
                            .clipShape(.rect)
                    }
                    
                    VStack(alignment: .center) {
                        Text(movieDetail.originalTitle)
                            .multilineTextAlignment(.center)
                            .font(.title3)
                            .bold()
                        
                        VStack(spacing: 20) {
                            HStack {
                                Text(movieDetail.originalLanguage)
                                
                                if movieDetail.isMovieRatedR {
                                    Text("R")
                                        .bold()
                                }
                                Text(movieDetail.releaseYear)
                            }
                            
                            VStack(spacing: 5) {
                                Image(systemName: "star.fill")
                                    .foregroundStyle(.yellow)
                                
                                VStack(spacing: -2) {
                                    Text("\(movieDetail.rating)/10")
                                        .bold()
                                    Text("\(movieDetail.totalVotes) votes")
                                        .font(.footnote)
                                        .foregroundStyle(.secondary)
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding(.top, -60)
                .padding([.leading, .trailing], 2)
        }
    }
    
    private struct MovieDetailsSection: View {
        let movieDetail: MovieDetail

        var body: some View {
          
            VStack(spacing: 10) {
                VStack(spacing: 5) {
                    Text("Overview:")
                        .font(.title2)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(movieDetail.overview)
                        .foregroundStyle(.secondary)
                        .bold()
                }
                .padding([.trailing], 5)
                
                VStack(alignment: .leading) {
                    Text("Details:")
                        .bold()
                        .font(.title2)
                    
                    if !movieDetail.releaseDate.isEmpty {
                        Text("Release Date")
                            .bold()
                        Text(movieDetail.releaseDate)
                    }
                    
                    Text("Genre")
                        .bold()
                    
                    Text(movieDetail.genres.map {$0.name}.joined(separator: ", "))
                    
                    Text("Countries of Origin")
                        .bold()
                    Text(movieDetail.productionCountries.map {$0.name}.joined(separator: ", "))
                    
                    Text("Language Spoken")
                        .bold()
                    Text(movieDetail.spokenLanguages.map {$0.englishName}.joined(separator: ", "))
                    
                    Text("Runtime")
                        .bold()
                    
                    Text(movieDetail.runtime)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(alignment: .leading) {
                    Text("Production Companies")
                        .font(.title2)
                        .bold()
                    
                    ScrollView(.horizontal, showsIndicators: false)  {
                        LazyHGrid(rows: [GridItem(.adaptive(minimum: 80, maximum: 300))]) {
                           
                            ForEach(movieDetail.productionCompanies) { company in
                                
                                VStack {
                                    if let logoURL = company.logoURL
                                    {
                                        AsyncCachedImage(url: logoURL, errorImage:                             AnyView (                         Circle()
                                            .fill(.gray)
                                        )
                                        )
                                        .background(Color.white)
                                        .aspectRatio(contentMode: .fit)
                                        .frame(maxWidth: 100, maxHeight: 50)
                                    }
                                    
                                    Text(company.name)
                                        .font(.caption2)
                                        .bold()
                                        .border(.background)
                                }
                            }
                        }
                    }
                }
            }
            .padding(.leading, 10)
        }
    }
}

#Preview {
    MovieDetailView(movieId: 558449)
}
