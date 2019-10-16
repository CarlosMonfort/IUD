//
//  MainWireframe.swift
//  IUD
//
//  Created by Carlos Monfort on 09/10/2019.
//  Copyright © 2019 Carlos Monfort. All rights reserved.
//

import UIKit

class MainWireframe: MainWireframeProtocol {
    
    // MARK: - Variables
    weak var viewController: UIViewController?
    
    // MARK: - Module Creation
    static func mCreateMainModule() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let mainViewController = storyboard.instantiateViewController(withIdentifier: "MainVC") as? MainViewController else { return UIViewController() }
        
        let presenter: MainPresenterProtocol & MainOutputInteractorProtocol = MainPresenter()
        let interactor: MainInputInteractorProtocol = MainInteractor()
        let wireframe = MainWireframe()
        
        mainViewController.presenter = presenter
        presenter.view = mainViewController
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        interactor.presenter = presenter
        wireframe.viewController = mainViewController
        
        return mainViewController
    }
    
    // MARK: - Navigation
    func mainWirePresentDetail(with user: User?) {
        let detailViewController = DetailWireframe.dCreateDetailModule(with: user)
        viewController?.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
