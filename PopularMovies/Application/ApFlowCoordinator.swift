//
//  ApFlowCoordinator.swift
//  PopularMovies
//
//  Created by Abdullah on 17/09/2022.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    func start()
}


extension Coordinator {

    func store(coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }

    func free(coordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
}

class BaseCoordinator : Coordinator {
    var childCoordinators : [Coordinator] = []
    var isCompleted: (() -> ())?

    func start() {
        fatalError("Children should implement `start`.")
    }
}

final class AppFlowCoordinator: BaseCoordinator {
  
    var window: UIWindow?
    let appDependencies: AppDependencies
    lazy var navigationController = UINavigationController()
    
    init(window: UIWindow?, appDependencies: AppDependencies) {
        self.window = window
        self.appDependencies = appDependencies
    }

    override func start() {
        window?.rootViewController = navigationController
        showHome(navigationController: navigationController)
        window?.makeKeyAndVisible()
    }
    
    func showHome(navigationController: UINavigationController) {
        let movieFlow = MovieFlowCoordinator.init(navigationController: navigationController, movieControllerFactory: MovieControllerFactory(appDependencies: appDependencies))
        store(coordinator: movieFlow)
        movieFlow.start()
        
        movieFlow.isCompleted = { [weak self] in
            self?.free(coordinator: movieFlow)
        }
    }
    
}
