//
//  MainPresenter.swift
//  IUD
//
//  Created by Carlos Monfort on 09/10/2019.
//  Copyright © 2019 Carlos Monfort. All rights reserved.
//

import UIKit

class MainPresenter: NSObject {
    
    // MARK: - Variables
    var view: MainViewProtocol?
    var interactor: MainInputInteractorProtocol?
    var wireframe: MainWireframeProtocol?
    var usersList: [User] = [] {
        didSet {
            view?.mainViewUpdateUsers()
        }
    }
    
    // MARK: - Setup View
    func viewDidLoad(from view: MainViewController) {
        view.navigationItem.title = NSLocalizedString("MAIN_TITLE", comment: "")
        setUpTableView(from: view)
    }
    
    func setUpTableView(from view: MainViewController) {
        view.tableView.delegate = self
        view.tableView.dataSource = self
        view.tableView.rowHeight = UITableView.automaticDimension
        view.tableView.tableFooterView = UIView()
        view.tableView.register(UserTableViewCell.nib, forCellReuseIdentifier: UserTableViewCell.identifier)
    }
}
