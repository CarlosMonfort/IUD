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
    weak var viewController: UIViewController?
    
    // MARK: - Module Creation
    static func dCreateDetailModule(with user: User?) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let detailViewController = storyboard.instantiateViewController(withIdentifier: "DetailVC") as? DetailViewController else { return UIViewController() }
        
        let presenter: DetailPresenterProtocol & DetailOutputInteractorProtocol = DetailPresenter()
        let interactor: DetailInputInteractorProtocol = DetailInteractor()
        let wireframe = DetailWireframe()
        
        detailViewController.presenter = presenter
        presenter.view = detailViewController
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        presenter.user = user
        interactor.presenter = presenter
        wireframe.viewController = detailViewController
        
        return detailViewController
    }
}
