//
//  MainViewPresenter.swift
//  IOS8-HW-21-DubinaRoman
//
//  Created by admin on 17.03.2023.
//

import Foundation

protocol MainViewControllerProtocol: AnyObject {
    func reloadData()
}

protocol CollectinViewCellProtocol: AnyObject {
    func configurate(by model: CharacterMarvel?)
}

protocol MainViewPresenterProtocol: AnyObject {
    var model: AnswerMarvelService? { get set }
    init(view: MainViewControllerProtocol, networkingService: NetworkingServiceProtocol)
    func getData()
}

class MainViewPresenter: MainViewPresenterProtocol {
    
    weak var view: MainViewControllerProtocol?
    let networkingService: NetworkingServiceProtocol
    var model: AnswerMarvelService?
    
    required init(view: MainViewControllerProtocol, networkingService: NetworkingServiceProtocol) {
        self.view = view
        self.networkingService = networkingService
        getData()
    }
    
    func getData() {
        networkingService.getData(url: networkingService.createUrlMarvel()) { result in
            switch result {
                case .success(let data):
                    self.model = data
                    self.view?.reloadData()
                case .failure(let error):
                    print(error)
            }
        }
    }
}
