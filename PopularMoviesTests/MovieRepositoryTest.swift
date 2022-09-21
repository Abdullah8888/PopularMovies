//
//  MovieRepositoryTest.swift
//  PopularMoviesTests
//
//  Created by Abdullah on 20/09/2022.
//

import Foundation
import XCTest
@testable import PopularMovies

class MovieRepositoryTest: XCTestCase {
    
    func test_movies_count() {
        let sut = makeSut()
        sut.getMovies { res in
            do {
                let movieResponse = try res.get()
                XCTAssertEqual(movieResponse.results?.count, 1)
            }
            catch {
                XCTFail("Failed to get response")
            }
        }
    }
    
    func makeSut(withSuccessResponse: Bool = true) -> MovieRepository {
        let remoteServiceMock = RemoteServiceMock()
        let movieRepository = MovieRepository.init(remoteService: remoteServiceMock)
        withSuccessResponse ? remoteServiceMock.makeSuccessData() : remoteServiceMock.makeFailData()
        return movieRepository
    }
}

/// MovieRepositoryMock
final class MovieRepositoryMock: MovieRepositoryProtocol {
    
    private let remoteService: RemoteServiceProtocol
    
    init(remoteService: RemoteServiceProtocol) {
        self.remoteService = remoteService
    }
    
    func getMovies(completion: @escaping (Result<MovieResponse, ErrorModel>) -> Void) {
        remoteService.fetch(pathUrl: "", type: MovieResponse.self) { result in
            switch result {
            case .success(let res):
                completion(.success(res))
            case .failure(let error):
                completion(.failure(ErrorModel(message: error.message)))
            }
        }
    }
    
    func getMoviesDetails(movieId: String, completion: @escaping (Result<PopularMovieDetailsResponse, ErrorModel>) -> Void) {
        
    }
}
