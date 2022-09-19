//
//  PopularMovieDetailController.swift
//  PopularMovies
//
//  Created by Abdullah on 17/09/2022.
//

import Foundation
import UIKit

final class PopularMovieDetailController: BaseController<PopularMovieDetailView> {
    
    weak var movieFlowCoordinator: MovieFlowCoordinator?
    var viewModel: PopularMovieDetailViewModel?
    var movieId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel?.popularMovieDetailsResponse.subscribe(weakify({ strongSelf, res in
            DispatchQueue.main.async {
                if let popularMovieDetailsResponse = res.element {
                    strongSelf.updateView(with: popularMovieDetailsResponse)
                }
                strongSelf.removeLoader()
            }
        })).disposed(by: disposeBag)
        
        viewModel?.errorHandler.subscribe(weakify({ strongSelf, error in
            DispatchQueue.main.async {
                strongSelf.showToastWithTItle(error.element?.message, type: .error)
                strongSelf.removeLoader()
            }
        })).disposed(by: disposeBag)
        
        guard let movieId = movieId else { return }
        showLoader()
        viewModel?.getPopularMovieDetails(movieId: movieId)
    }
    
    func updateView(with popularMovieDetails: PopularMovieDetailsResponse) {
        _view.titleLabel.text = popularMovieDetails.title ?? "Not Found"
        _view.overViewLabel.text = popularMovieDetails.overview ?? "Not Found"
        _view.posterImage.showImage(url: .posterHost + (popularMovieDetails.posterPath ?? ""))
    }
}
