//
//  GetPopularMoviesDetailsUseCase.swift
//  PopularMovies
//
//  Created by Abdullah on 18/09/2022.
//

import Foundation

protocol GetPopularMoviesDetailsUseCaseProtocol: AnyObject {
    func getMoviesDetails(movieId: String, completion: @escaping (Result<MovieResponse, ErrorModel>) -> Void)
}

final class GetPopularMoviesDetailsUseCase: GetPopularMoviesDetailsUseCaseProtocol {

    private let movieRepository: MovieRepositoryProtocol
    
    init(movieRepository: MovieRepositoryProtocol) {
        self.movieRepository = movieRepository
    }
    
    func getMoviesDetails(movieId: String, completion: @escaping (Result<MovieResponse, ErrorModel>) -> Void) {
        movieRepository.getMoviesDetails(movieId: movieId, completion: completion)
    }
}
