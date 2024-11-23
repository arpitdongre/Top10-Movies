//
//  Top10_MoviesApp.swift
//  Top10 Movies
//
//  Created by Arpit Dongre on 12/11/24.
//

import SwiftUI

@main
struct Top10_MoviesApp: App {
    var body: some Scene {
        WindowGroup {
            MovieListView()
                .navigationTitle("Popular Movies")
        }
    }
}
