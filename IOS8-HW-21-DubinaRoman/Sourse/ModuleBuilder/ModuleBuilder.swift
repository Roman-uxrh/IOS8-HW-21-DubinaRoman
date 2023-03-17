//
//  ModuleBuilder.swift
//  IOS8-HW-21-DubinaRoman
//
//  Created by admin on 17.03.2023.
//

import UIKit

protocol ModuleBuilderProtocol {
    static func createMainView() -> UIViewController
    static func createDetailView(character: CharacterMarvel) -> UIViewController
}

class ModuleBuilder: ModuleBuilderProtocol {
    
    static func createMainView() -> UIViewController {
        let view = MainViewController()
        let networkingService = NetworkingService()
        let presenter = MainViewPresenter(view: view, networkingService: networkingService)
        view.presenter = presenter
        return view
    }
    
    static func createDetailView(character: CharacterMarvel) -> UIViewController {
        let view = DetailViewController()
        let presenter = DetailViewPresenter(view: view, model: character)
        view.presenter = presenter
        return view
    }
    
    
}
