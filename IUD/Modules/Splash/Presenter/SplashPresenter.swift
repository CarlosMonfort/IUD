//
//  SplashPresenter.swift
//  IUD
//
//  Created by Carlos Monfort Gómez on 10/10/2019.
//  Copyright © 2019 Carlos Monfort. All rights reserved.
//

import UIKit

class SplashPresenter {
    
    var view: SplashViewProtocol?
    var interactor: SplashInputInteractorProtocol?
    var wireframe: SplashWireframeProtocol?
    var splashVC: SplashViewController!
    
    func viewDidLoad() {
        splashVC.activityIndicator.startAnimating()
        splashVC.lbTitle.text = NSLocalizedString("SPLASH_TITLE", comment: "")
        splashVC.lbTitle.font = UIFont.preferredFont(forTextStyle: .title1)
        splashVC.lbTitle.numberOfLines = 0
        splashVC.lbTitle.lineBreakMode = .byWordWrapping
    }
}

extension SplashPresenter: SplashPresenterProtocol {
    
    func splashPresenterViewDidLoad(from view: SplashViewController) {
        splashVC = view
        viewDidLoad()
    }
    
    func splashPresenterViewDidAppear() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.splashPresenterPresentMain()
        }
    }
    
    func splashPresenterPresentMain() {
        wireframe?.splashWirePresentMain(from: splashVC)
    }
}

extension SplashPresenter: SplashOutputInteractorProtocol {
    
    func splashOutputError(error: APIError) {
        view?.splashViewError(error: error)
    }
}
