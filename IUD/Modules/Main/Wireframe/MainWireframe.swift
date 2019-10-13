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
    static var storyboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    // MARK: - Module Creation
    static func mCreateMainModule() -> UIViewController {
        guard let mainViewController = storyboard.instantiateViewController(withIdentifier: "MainVC") as? MainViewController else { return UIViewController() }
        
        let presenter: MainPresenterProtocol & MainOutputInteractorProtocol = MainPresenter()
        let interactor: MainInputInteractorProtocol = MainInteractor()
        let wireframe = MainWireframe()
        
        mainViewController.presenter = presenter
        presenter.view = mainViewController
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        interactor.presenter = presenter
        
        return mainViewController
    }
    
    // MARK: - Navigation
    func mainWirePresentDetail(from view: UIViewController, with user: User?) {
        guard let detailViewController = view.storyboard?.instantiateViewController(withIdentifier: "DetailVC") as? DetailViewController else { return }
        DetailWireframe.dCreateDetailModule(from: detailViewController, with: user)
        view.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
