//
//  AppDelegate.swift
//  PopularMovies
//
//  Created by Abdullah on 17/09/2022.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appFlowCoordinator: Coordinator?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        appFlowCoordinator = AppFlowCoordinator(window: window, appDependencies: AppDependencies())
        appFlowCoordinator?.start()
        return true
    }

}

