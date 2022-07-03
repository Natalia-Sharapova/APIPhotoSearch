//
//  DetailPresenter.swift
//  APIPhotoSearch
//
//  Created by Наталья Шарапова on 24.06.2022.
//

import Foundation

protocol DetailViewProtocol: AnyObject {
    func showPhoto(photo: String)
}

protocol DetailViewPresenterProtocol: AnyObject {
    
    init(view: DetailViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol, photo: String)
    func setPhoto()
}

class DetailPresenter: DetailViewPresenterProtocol {
    
    // MARK: - Properties
    
    weak var view: DetailViewProtocol?
    var networkService: NetworkServiceProtocol
    var photo: String
    var router: RouterProtocol?
    
    required init(view: DetailViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol, photo: String) {
        self.view = view
        self.networkService = networkService
        self.photo = photo
        self.router = router
    }
    
    // MARK: - Method
    
    public func setPhoto() {
        view?.showPhoto(photo: photo)
    }
}

