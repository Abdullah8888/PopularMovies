//
//  GetPopularMoviesUseCaseTes.swift
//  PopularMoviesTests
//
//  Created by Abdullah on 19/09/2022.
//

import Foundation
import XCTest
@testable import PopularMovies

class GetPopularMoviesUseCaseTest: XCTestCase {
    
    
    func test_movies_fetched_successfully() throws {
        let sut = makeSut()
        sut.getMovies { res in
            let moviewResponse = try? res.get()
            XCTAssertEqual(moviewResponse?.results?.isEmpty, false)
        }
    }
    
    func test_movies_fetched_failed() {
        let sut = makeSut()
        sut.getMovies { res in
            do {
                _ = try res.get()
            }
            catch {
                let message = error.localizedDescription
                XCTAssertEqual(message, "Unable to decode data")
            }
        }
    }
    
    func makeSut() -> GetPopularMoviesUseCase {
        let remoteServiceMock = RemoteServiceMock()
        let movieRepository = MovieRepository(remoteService: remoteServiceMock)
        let getPopularMoviesUseCase = GetPopularMoviesUseCase(movieRepository: movieRepository)
        return getPopularMoviesUseCase
    }
}


/// GetPopularMoviesUseCaseMock
final class GetPopularMoviesUseCaseMock: GetPopularMoviesUseCaseProtocol {
    
    private let movieRepository: MovieRepositoryProtocol
    
    init(movieRepository: MovieRepositoryProtocol) {
        self.movieRepository = movieRepository
    }
    
    func getMovies(completion: @escaping (Result<MovieResponse, ErrorModel>) -> Void) {
        movieRepository.getMovies(completion: completion)
    }
}

/// GetPopularMoviesDetailsUseCaseMock
final class GetPopularMoviesDetailsUseCaseMock: GetPopularMoviesDetailsUseCaseProtocol {

    private let movieRepository: MovieRepositoryProtocol
    
    init(movieRepository: MovieRepositoryProtocol) {
        self.movieRepository = movieRepository
    }
    
    func getMoviesDetails(movieId: String, completion: @escaping (Result<PopularMovieDetailsResponse, ErrorModel>) -> Void) {
        movieRepository.getMoviesDetails(movieId: movieId, completion: completion)
    }
}
