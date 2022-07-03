//
//  ModuleBuilder.swift
//  APIPhotoSearch
//
//  Created by Наталья Шарапова on 22.06.2022.
//

import UIKit

// Creating protocol for builder

protocol BuilderProtocol {
    func createMainModule(router: RouterProtocol) -> UIViewController
    func createDetailModule(photo: String, router: RouterProtocol) -> UIViewController
}

class ModuleBuilder: BuilderProtocol {
    
    // MARK: - Methods
    
    func createDetailModule(photo: String, router: RouterProtocol) -> UIViewController {
        let view = DetailViewController()
        let networkService = NetworkService()
        let presenter = DetailPresenter(view: view, networkService: networkService, router: router, photo: photo)
        view.presenter = presenter
        return view
    }
    
    func createMainModule(router: RouterProtocol) -> UIViewController {
        let view = MainViewController()
        let networkService = NetworkService()
        let presenter = MainPresenter(view: view, networkService: networkService, router: router)
        view.presenter = presenter
        return view
    }
}
