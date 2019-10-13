//
//  SplashViewController.swift
//  IUD
//
//  Created by Carlos Monfort on 10/10/2019.
//  Copyright © 2019 Carlos Monfort. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Variables
    var presenter: SplashPresenterProtocol?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.splashPresenterViewDidLoad(from: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        presenter?.splashPresenterViewDidAppear()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let mainViewController = MainWireframe.mCreateMainModule()
            let navController = UINavigationController(rootViewController: mainViewController)
            navController.modalPresentationStyle = .overFullScreen
            self.present(navController, animated: true, completion: nil)
        }
    }
}

extension SplashViewController: SplashViewProtocol {
    
    func splashViewError(error: APIError) {
        self.presentAlert(title: NSLocalizedString("ALERT_ERROR", comment: ""), message: error.localizedDescription)
    }
}
