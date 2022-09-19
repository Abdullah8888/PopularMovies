//
//  PopularMovieDetailViewModel.swift
//  PopularMovies
//
//  Created by Abdullah on 17/09/2022.
//

import Foundation
import RxSwift

class PopularMovieDetailViewModel {
    private let getPopularMoviesDetailsUseCase: GetPopularMoviesDetailsUseCaseProtocol
    
    var popularMovieDetailsResponse: PublishSubject<PopularMovieDetailsResponse> = PublishSubject<PopularMovieDetailsResponse>()
    var errorHandler: PublishSubject<ErrorModel> = PublishSubject<ErrorModel>()
    
    init(getPopularMoviesDetailsUseCase: GetPopularMoviesDetailsUseCaseProtocol) {
        self.getPopularMoviesDetailsUseCase = getPopularMoviesDetailsUseCase
    }
    
    func getPopularMovieDetails(movieId: Int) {
        getPopularMoviesDetailsUseCase.getMoviesDetails(movieId: "\(movieId)") { result in
            switch result {
            case .success(let res):
                self.popularMovieDetailsResponse.onNext(res)
            case .failure(let err):
                self.errorHandler.onNext(err)
            }
        }
    }
}
