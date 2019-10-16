//
//  SplashWireframe.swift
//  IUD
//
//  Created by Carlos Monfort Gómez on 10/10/2019.
//  Copyright © 2019 Carlos Monfort. All rights reserved.
//

import UIKit

class SplashWireframe: SplashWireframeProtocol {
    
    // MARK: - Variables
    weak var viewController: UIViewController?
    
    // MARK: - Module Creation
    static func sCreateSplashModule() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let splashViewController = storyboard.instantiateViewController(withIdentifier: "SplashVC") as? SplashViewController else { return UIViewController() }
        
        let presenter: SplashPresenterProtocol & SplashOutputInteractorProtocol = SplashPresenter()
        let interactor: SplashInputInteractorProtocol = SplashInteractor()
        let wireframe = SplashWireframe()
        
        splashViewController.presenter = presenter
        presenter.view = splashViewController
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        interactor.presenter = presenter
        wireframe.viewController = splashViewController
        
        return splashViewController
    }
    
    func splashWirePresentMain() {
        let mainViewController = MainWireframe.mCreateMainModule()
        let navController = UINavigationController(rootViewController: mainViewController)
        navController.modalPresentationStyle = .overFullScreen
        viewController?.present(navController, animated: true, completion: nil)
    }
}
