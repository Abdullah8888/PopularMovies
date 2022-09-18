//
//  ControllerDIContainer.swift
//  PopularMovies
//
//  Created by Abdullah on 17/09/2022.
//

import Foundation

protocol MovieControllerFactoryProtocol {
    func makePopularMovieController() -> PopularMovieController
    func makePopularMovieDetailController() -> PopularMovieDetailController
}

final class MovieControllerFactory: MovieControllerFactoryProtocol {
    
    private let appDependencies: AppDependencies
    
    init(appDependencies: AppDependencies) {
        self.appDependencies = appDependencies
    }
    func makePopularMovieController() -> PopularMovieController {
        let vc = PopularMovieController(view: PopularMovieView())
        vc.viewModel = PopularMovieViewModel.init(getPopularMoviesUseCase: appDependencies.makeGetPopularMoviesUseCase())
        return vc
    }
    
    func makePopularMovieDetailController() -> PopularMovieDetailController {
        let vc = PopularMovieDetailController(view: PopularMovieDetailView())
        vc.viewModel = PopularMovieDetailViewModel.init(getPopularMoviesDetailsUseCase: appDependencies.makeGetPopularMoviesDetailsUseCase())
        return vc
    }
}
