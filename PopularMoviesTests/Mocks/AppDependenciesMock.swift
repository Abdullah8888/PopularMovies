//
//  AppDependenciesMock.swift
//  PopularMoviesTests
//
//  Created by Abdullah on 20/09/2022.
//

import Foundation
@testable import PopularMovies

final class AppDependenciesMock: AppDependenciesProtocol {
    
    
    func makeGetPopularMoviesDetailsUseCase() -> GetPopularMoviesDetailsUseCaseProtocol {
        GetPopularMoviesDetailsUseCaseMock(movieRepository: makeMovieRepository())
    }
    
    func makeGetPopularMoviesUseCase() -> GetPopularMoviesUseCaseProtocol {
        GetPopularMoviesUseCaseMock(movieRepository: makeMovieRepository())
    }
    
    func makeMovieRepository() -> MovieRepositoryProtocol {
        MovieRepositoryMock(remoteService: makeRemoteService())
    }
    
    func makeRemoteService() -> RemoteServiceProtocol {
        RemoteServiceMock()
    }
}
