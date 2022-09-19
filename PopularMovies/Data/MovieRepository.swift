//
//  MovieRepository.swift
//  PopularMovies
//
//  Created by Abdullah on 17/09/2022.
//

import Foundation
protocol MovieRepositoryProtocol {
    func getMovies(completion: @escaping (Result<MovieResponse, ErrorModel>) -> Void)
    func getMoviesDetails(movieId: String, completion: @escaping (Result<PopularMovieDetailsResponse, ErrorModel>) -> Void)
}

final class MovieRepository: MovieRepositoryProtocol {
    
    private let remoteService: RemoteServiceProtocol
    
    init(remoteService: RemoteServiceProtocol) {
        self.remoteService = remoteService
    }
    
    func getMovies(completion: @escaping (Result<MovieResponse, ErrorModel>) -> Void) {
        remoteService.fetch(pathUrl: .popularMoviesPathUrl + "popular", type: MovieResponse.self) { result in
            switch result {
            case .success(let res):
                completion(.success(res))
            case .failure(let error):
                completion(.failure(ErrorModel(message: error.message)))
            }
        }
    }
    
    func getMoviesDetails(movieId: String, completion: @escaping (Result<PopularMovieDetailsResponse, ErrorModel>) -> Void) {
        remoteService.fetch(pathUrl: .popularMoviesPathUrl + movieId, type: PopularMovieDetailsResponse.self) { result in
            switch result {
            case .success(let res):
                completion(.success(res))
            case .failure(let error):
                completion(.failure(ErrorModel(message: error.message)))
            }
        }
    }
}

