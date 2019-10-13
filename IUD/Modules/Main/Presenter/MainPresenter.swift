//
//  MainPresenter.swift
//  IUD
//
//  Created by Carlos Monfort on 09/10/2019.
//  Copyright © 2019 Carlos Monfort. All rights reserved.
//

import UIKit

class MainPresenter {
    
    // MARK: - Variables
    var view: MainViewProtocol?
    var interactor: MainInputInteractorProtocol?
    var wireframe: MainWireframeProtocol?
    var mainView: MainViewController!
    
    // MARK: - Setup View
    func viewDidLoad() {
        mainView.navigationItem.title = NSLocalizedString("MAIN_TITLE", comment: "")
        setUpTableView()
    }
    
    func setUpTableView() {
        mainView.tableView.delegate = mainView
        mainView.tableView.dataSource = mainView
        mainView.tableView.rowHeight = UITableView.automaticDimension
        mainView.tableView.tableFooterView = UIView()
        mainView.tableView.register(UserTableViewCell.nib, forCellReuseIdentifier: UserTableViewCell.identifier)
    }
}

extension MainPresenter: MainPresenterProtocol {
    
    func mainPresenterViewDidLoad(from view: MainViewController) {
        mainView = view
        viewDidLoad()
    }
    
    func mainPresenterViewWillAppear() {
        mainPresenterGetUsers()
    }
    
    func mainPresenterGetUsers() {
        interactor?.mainInputGetUsers()
    }
    
    func mainPresenterPresentDetail(from user: User?) {
        wireframe?.mainWirePresentDetail(from: mainView, with: user)
    }
}

extension MainPresenter: MainOutputInteractorProtocol {
    
    func mainOutputUsersDataFetched(users: [User]) {
        DispatchQueue.main.async {
            self.view?.mainViewUpdateUsers(with: users)
        }
    }
    
    func mainOutputError(error: APIError) {
        DispatchQueue.main.async {
            self.view?.mainViewError(error: error)
        }
    }
}
