//
//  PopularMovieViewModel.swift
//  PopularMovies
//
//  Created by Abdullah on 17/09/2022.
//

import Foundation
import RxSwift

final class PopularMovieViewModel {
    
    private let getPopularMoviesUseCase: GetPopularMoviesUseCaseProtocol
    var movieResponse: PublishSubject<MovieResponse> = PublishSubject<MovieResponse>()
    var errorHandler: PublishSubject<ErrorModel> = PublishSubject<ErrorModel>()
    
    init(getPopularMoviesUseCase: GetPopularMoviesUseCaseProtocol) {
        self.getPopularMoviesUseCase = getPopularMoviesUseCase
    }
    
    func getMovies() {
        getPopularMoviesUseCase.getMovies { result in
            switch result {
            case .success(let res):
                print("the res is \(res.results)")
                self.movieResponse.onNext(res)
            case .failure(let err):
                self.errorHandler.onNext(err)
            }
        }
    }
}
