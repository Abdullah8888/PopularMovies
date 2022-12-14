//
//  PopularMovie.swift
//  PopularMovies
//
//  Created by Abdullah on 17/09/2022.
//

import Foundation

// MARK: - MovieRespose
struct MovieResponse: Codable {
    let results: [Movie]?
}

// MARK: - MovieResult
struct Movie: Codable {
    let id: Int?
    //let originalLanguage, originalTitle, overview: String?
    let popularity: Double?
    let posterPath, overview, title: String?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case overview, popularity
        case posterPath = "poster_path"
        case title
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
