//
//  XCTestCase+Extension.swift
//  PopularMoviesTests
//
//  Created by Abdullah on 20/09/2022.
//

import Foundation
import XCTest
@testable import PopularMovies

extension XCTestCase {
    func waitOrFail(timeout: TimeInterval) {
        let expectation = self.expectation(description: #function)

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + timeout, execute: {
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: timeout + 2)
    }
}
