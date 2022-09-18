//
//  PopularMovieViewModel.swift
//  PopularMovies
//
//  Created by Abdullah on 17/09/2022.
//

import Foundation

final class PopularMovieViewModel {
    
    private let getPopularMoviesUseCase: GetPopularMoviesUseCaseProtocol
    
    init(getPopularMoviesUseCase: GetPopularMoviesUseCaseProtocol) {
        self.getPopularMoviesUseCase = getPopularMoviesUseCase
    }
}
