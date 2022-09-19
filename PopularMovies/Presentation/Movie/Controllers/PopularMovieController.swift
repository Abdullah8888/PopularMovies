//
//  PopularMovieController.swift
//  PopularMovies
//
//  Created by Abdullah on 17/09/2022.
//

import Foundation
import UIKit

final class PopularMovieController: BaseController<PopularMovieView> {
    
    weak var movieFlowCoordinator: MovieFlowCoordinator?
    var viewModel: PopularMovieViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Popular Movies"
        
        viewModel?.movieResponse.subscribe(weakify({ strongSelf, res in
            DispatchQueue.main.async {
                strongSelf._view.movies = res.element?.results
                strongSelf.removeLoader()
            }
        })).disposed(by: disposeBag)
        
        viewModel?.errorHandler.subscribe(weakify({ strongSelf, error in
            DispatchQueue.main.async {
                strongSelf.showToastWithTItle(error.element?.message, type: .error)
                strongSelf.removeLoader()
            }
        })).disposed(by: disposeBag)
        
        _view.alertHandler = weakify({ strongSelf, movieName in
            if movieName.isEmpty { return }
            strongSelf.showAlert(for: movieName)
        })
        
        showLoader()
        self.viewModel?.getMovies()
        
        _view.movieFlowCoordinator = movieFlowCoordinator
    }
    
    func showAlert(for moviewName: String) {
        let alert = UIAlertController(title: moviewName, message: "", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
