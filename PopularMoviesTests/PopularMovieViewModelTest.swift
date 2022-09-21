//
//  MovieViewModelTest.swift
//  PopularMoviesTests
//
//  Created by Abdullah on 19/09/2022.
//

import XCTest
@testable import PopularMovies
import RxSwift

class PopularMovieViewModelTest: XCTestCase {
    
    func test_movies_count() {
        let expectation = self.expectation(description: #function)
        let sut = makeSut()
        let recorder = Recorder<MovieResponse>()
        recorder.on(valueSubject: sut.movieResponse)
        sut.getMovies()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now(), execute: {
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(recorder.value?.results?.count, 1)
    }
    
    func test_undecoded_movie_data() {
        let expectation = self.expectation(description: #function)
        let sut = makeSut(hasWrongResponse: true)
        let recorder = Recorder<ErrorModel>()
        recorder.on(errorValueSubject: sut.errorHandler)
        sut.getMovies()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now(), execute: {
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1)
        XCTAssertNotNil(recorder.error?.message)
    }
    
    func makeSut(hasWrongResponse: Bool = false) -> PopularMovieViewModel {
        let remoteServiceMock = RemoteServiceMock()
        hasWrongResponse ? remoteServiceMock.makeFailData() : remoteServiceMock.makeSuccessData()
        let movieRepositoryMock = MovieRepository.init(remoteService: remoteServiceMock)
        let getPopularMoviesUseCaseMock = GetPopularMoviesUseCase.init(movieRepository: movieRepositoryMock)
        let vm = PopularMovieViewModel(getPopularMoviesUseCase: getPopularMoviesUseCaseMock)
        return vm
    }
    
}
