//
//  GetPopularMoviesUseCase.swift
//  PopularMovies
//
//  Created by Abdullah on 17/09/2022.
//

import Foundation

protocol GetPopularMoviesUseCaseProtocol: AnyObject {
    func getMovies(completion: @escaping (Result<MovieResponse, ErrorModel>) -> Void)
}

final class GetPopularMoviesUseCase: GetPopularMoviesUseCaseProtocol {

    private let movieRepository: MovieRepositoryProtocol
    
    init(movieRepository: MovieRepositoryProtocol) {
        self.movieRepository = movieRepository
    }
    
    func getMovies(completion: @escaping (Result<MovieResponse, ErrorModel>) -> Void) {
        movieRepository.getMovies(completion: completion)
    }
}

