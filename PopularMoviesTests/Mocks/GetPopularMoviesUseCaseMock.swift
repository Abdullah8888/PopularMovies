//
//  GetPopularMoviesUseCaseMock.swift
//  PopularMoviesTests
//
//  Created by Abdullah on 21/09/2022.
//

import Foundation
@testable import PopularMovies

final class GetPopularMoviesUseCaseMock: GetPopularMoviesUseCaseProtocol {
    
    private let movieRepository: MovieRepositoryProtocol
    
    init(movieRepository: MovieRepositoryProtocol) {
        self.movieRepository = movieRepository
    }
    
    func getMovies(completion: @escaping (Result<MovieResponse, ErrorModel>) -> Void) {
        movieRepository.getMovies(completion: completion)
    }
}
