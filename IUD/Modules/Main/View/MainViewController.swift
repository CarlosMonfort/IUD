//
//  MainViewController.swift
//  IUD
//
//  Created by Carlos Monfort on 09/10/2019.
//  Copyright © 2019 Carlos Monfort. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var barBTNewUser: UIBarButtonItem!
    
    // MARK: - Variables
    var presenter: MainPresenterProtocol?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.mainPresenterViewDidLoad(from: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        presenter?.mainPresenterViewWillAppear()
    }

    @IBAction func barBtNewUserPressed(_ sender: Any) {
        presenter?.mainPresenterPresentDetail(from: nil)
    }
}

extension MainViewController: MainViewProtocol {
    
    func mainViewUpdateUsers() {
        tableView.reloadData()
    }
    
    func mainViewError(error: APIError) {
        presentAlert(title: NSLocalizedString("ALERT_ERROR", comment: ""), message: error.localizedDescription)
    }
}
