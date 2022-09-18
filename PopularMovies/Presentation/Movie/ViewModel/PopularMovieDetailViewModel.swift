//
//  PopularMovieDetailViewModel.swift
//  PopularMovies
//
//  Created by Abdullah on 17/09/2022.
//

import Foundation

class PopularMovieDetailViewModel {
    private let getPopularMoviesDetailsUseCase: GetPopularMoviesDetailsUseCaseProtocol
    
    init(getPopularMoviesDetailsUseCase: GetPopularMoviesDetailsUseCaseProtocol) {
        self.getPopularMoviesDetailsUseCase = getPopularMoviesDetailsUseCase
    }
}
