//
//  DetailWireframe.swift
//  IUD
//
//  Created by Carlos Monfort on 09/10/2019.
//  Copyright © 2019 Carlos Monfort. All rights reserved.
//

import UIKit

class DetailWireframe: DetailWireframeProtocol {
    
    // MARK: - Variables
    static var storyboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    // MARK: - Module Creation
    static func dCreateDetailModule(from view: DetailViewController, with user: User?) {
        let presenter: DetailPresenterProtocol & DetailOutputInteractorProtocol = DetailPresenter()
        let interactor: DetailInputInteractorProtocol = DetailInteractor()
        let wireframe = DetailWireframe()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        presenter.user = user
        interactor.presenter = presenter
    }
}
