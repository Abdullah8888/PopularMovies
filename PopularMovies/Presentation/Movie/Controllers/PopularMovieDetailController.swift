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
    }
}
