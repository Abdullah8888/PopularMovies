//
//  RemoteServiceTest.swift
//  PopularMoviesTests
//
//  Created by Abdullah on 20/09/2022.
//

import Foundation
import XCTest
@testable import PopularMovies

class RemoteServiceTest: XCTestCase {
    
    func test_remote_service_with_success_response() {
        let sut = makeSut()
        sut.makeSuccessData()
        sut.fetch(pathUrl: "", type: MovieResponse.self) { res in
            do {
                let response = try res.get()
                XCTAssertEqual(response.results?.isEmpty, false)
            }
            catch {
                XCTFail("Failed")
            }
        }
    }
    
    func test_remote_service_with_failure_response() {
        let sut = makeSut()
        sut.makeFailData()
        sut.fetch(pathUrl: "", type: MovieResponse.self) { res in
            do {
                _ = try res.get()
            }
            catch {
                let dd = error as? ErrorModel
                XCTAssertEqual(dd?.message, "Unable to decode data")
            }
        }
    }
    
    func makeSut() -> RemoteServiceMock {
        let remoteServiceMock = RemoteServiceMock()
        return remoteServiceMock
    }
}


/// RemoteServiceMock
final class RemoteServiceMock: RemoteServiceProtocol {
    private var data = Data("".utf8)
    
    func fetch<T>(pathUrl: String, type: T.Type, completionHandler completion: @escaping (Result<T, ErrorModel>) -> Void) where T : Decodable, T : Encodable {
        
        do {
            let decodedResponse = try JSONDecoder().decode(type.self, from: data)
            completion(.success(decodedResponse))
        }
        catch {
            completion(.failure(ErrorModel(message: "Unable to decode data")))
        }
    }
    
    func makeSuccessData() {
        let stringData = "{\"results\":[{\"id\":985939,\"overview\":\"For best friends Becky and Hunter, life is all about conquering fears and pushing limits. But after they climb 2,000 feet to the top of a remote, abandoned radio tower, they find themselves stranded with no way down. Now Becky and Hunter’s expert climbing skills will be put to the ultimate test as they desperately fight to survive the elements, a lack of supplies, and vertigo-inducing heights\",\"popularity\":9320.962,\"poster_path\":\"/9f5sIJEgvUpFv0ozfA6TurG4j22.jpg\",\"title\":\"Fall\",\"vote_average\":7.4,}]}"
        data = Data(stringData.utf8)
    }
    
    func makeFailData() {
        data = Data("fail".utf8)
    }
    
}
