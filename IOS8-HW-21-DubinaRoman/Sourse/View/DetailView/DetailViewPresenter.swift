//
//  DetailViewCellPresenter.swift
//  IOS8-HW-21-DubinaRoman
//
//  Created by admin on 17.03.2023.
//

import Foundation

protocol DetailViewProtocol: AnyObject {
    func configurate(by model: CharacterMarvel?)
}

protocol DetailViewPresenterProtocol: AnyObject {
    var model: CharacterMarvel { get set }
    init(view: DetailViewProtocol, model: CharacterMarvel)
}

class DetailViewPresenter: DetailViewPresenterProtocol {
    weak var view: DetailViewProtocol?
    var model: CharacterMarvel
    
    required init(view: DetailViewProtocol, model: CharacterMarvel) {
        self.view = view
        self.model = model
    }
}
