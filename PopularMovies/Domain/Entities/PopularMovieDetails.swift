//
//  PopularMovieDetails.swift
//  PopularMovies
//
//  Created by Abdullah on 19/09/2022.
//

import Foundation

// MARK: - PopularMovieDetails
struct PopularMovieDetailsResponse: Codable {
    let homepage: String
    let id: Int?
    let overview: String?
    let popularity: Double?
    let posterPath: String?
    let title: String?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case homepage, id
        case overview, popularity
        case posterPath = "poster_path"
        case title
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
