//
//  Router.swift
//  APIPhotoSearch
//
//  Created by Наталья Шарапова on 25.06.2022.
//

import UIKit

// Creating protocol for router

protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var builder: BuilderProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
    func showInitialViewController()
    func showDetailViewController(photo: String)
    func popToRoot()
}

class Router: RouterProtocol {
    
    // MARK: - Properties
    
    var navigationController: UINavigationController?
    var builder: BuilderProtocol?
    
    init(navigationController: UINavigationController, builder: BuilderProtocol) {
        self.navigationController = navigationController
        self.builder = builder
    }
    
    // MARK: - Methods
    
    func showInitialViewController() {
        if let navigationController = navigationController {
            guard let mainViewController = builder?.createMainModule(router: self) else { return }
            navigationController.viewControllers = [mainViewController]
        }
    }
    
    func showDetailViewController(photo: String) {
        if let navigationController = navigationController {
            guard let detailViewController = builder?.createDetailModule(photo: photo, router: self) else { return }
            navigationController.pushViewController(detailViewController, animated: true)
        }
    }
    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
}
