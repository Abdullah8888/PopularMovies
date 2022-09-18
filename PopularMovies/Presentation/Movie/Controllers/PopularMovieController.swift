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
    }
}
