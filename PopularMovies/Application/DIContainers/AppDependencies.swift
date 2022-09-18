//
//  AppDIContainer.swift
//  PopularMovies
//
//  Created by Abdullah on 17/09/2022.
//

import Foundation


protocol AppDependenciesProtocol {
    func makeGetPopularMoviesDetailsUseCase() -> GetPopularMoviesDetailsUseCaseProtocol
    func makeGetPopularMoviesUseCase() -> GetPopularMoviesUseCaseProtocol
    func makeMovieRepository() -> MovieRepositoryProtocol
    func makeRemoteService() -> RemoteServiceProtocol
}

final class AppDependencies: AppDependenciesProtocol {
    
    func makeGetPopularMoviesDetailsUseCase() -> GetPopularMoviesDetailsUseCaseProtocol {
        GetPopularMoviesDetailsUseCase(movieRepository: makeMovieRepository())
    }
    
    func makeGetPopularMoviesUseCase() -> GetPopularMoviesUseCaseProtocol {
        GetPopularMoviesUseCase(movieRepository: makeMovieRepository())
    }
    
    func makeMovieRepository() -> MovieRepositoryProtocol {
        MovieRepository(remoteService: makeRemoteService())
    }
    
    func makeRemoteService() -> RemoteServiceProtocol {
        RemoteService()
    }
}
