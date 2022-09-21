//
//  Recorder.swift
//  PopularMoviesTests
//
//  Created by Abdullah on 20/09/2022.
//

import Foundation
import RxSwift

class Recorder<T> {
    var items = [T]()
    let bag = DisposeBag()
    var error: T?
    var value: T?
    
    func on(arraySubject: PublishSubject<[T]>) {
        arraySubject.subscribe(onNext: { value in
            self.items = value
        }).disposed(by: bag)
    }

    func on(valueSubject: PublishSubject<T>) {
        valueSubject.subscribe(onNext: { value in
            self.value = value
        }).disposed(by: bag)
    }
    
    func on(errorValueSubject: PublishSubject<T>) {
        errorValueSubject.subscribe(onNext: { value in
            self.error = value
        }).disposed(by: bag)
    }
}
