//
//  DetailPresenter.swift
//  IUD
//
//  Created by Carlos Monfort on 09/10/2019.
//  Copyright © 2019 Carlos Monfort. All rights reserved.
//

import UIKit

class DetailPresenter: NSObject {
    
    // MARK: - Variables
    var view: DetailViewProtocol?
    var interactor: DetailInputInteractorProtocol?
    var wireframe: DetailWireframeProtocol?
    var user: User?
    var userNameEdit: String?
    var userDateEdit: Date?
    var userTimeEdit: Date?
    var detailItems: [DetailItem] = [] {
        didSet {
            view?.detailViewUpdateItems()
        }
    }
    
    func viewDidLoad(from view: DetailViewController) {
        view.navigationItem.title = NSLocalizedString("DETAIL_TITLE", comment: "")
        setUpTableView(from: view)
        if let user = user {
            interactor?.detailInputGetUser(id: user.id)
        } else {
            interactor?.detailInputGetEmptyItems()
        }
        
    }
    
    func setUpTableView(from view: DetailViewController) {
        view.tableView.delegate = self
        view.tableView.dataSource = self
        view.tableView.rowHeight = UITableView.automaticDimension
        view.tableView.estimatedRowHeight = 70
        view.tableView.tableFooterView = UIView()
        view.tableView.register(DetailNameTableViewCell.nib, forCellReuseIdentifier: DetailNameTableViewCell.identifier)
        view.tableView.register(DetailHourTableViewCell.nib, forCellReuseIdentifier: DetailHourTableViewCell.identifier)
        view.tableView.register(DetailBirthdayTableViewCell.nib, forCellReuseIdentifier: DetailBirthdayTableViewCell.identifier)
    }
    
    func saveData() {
        interactor?.detailInputUpdateUser(currentUser: user, name: userNameEdit, date: userDateEdit, time: userTimeEdit)
    }
}

extension DetailPresenter: DetailPresenterProtocol {
    
    func detailPresenterViewDidLoad(from view: DetailViewController) {
        viewDidLoad(from: view)
    }
    
    func detailPresenterBarBtDeletePressed() {
        guard let user = user else { return }
        interactor?.detailInputDeleteUser(id: user.id)
    }
    
    func detailPresenterBarBtUndoPressed() {
        guard let user = user else { return }
        detailUserDataFetched(user: user, items: detailItems)
    }
    
    func detailPresenterBarBtSavePressed() {
        saveData()
    }
    
    func detailPresenterUserNameChanges(_ newName: String) {
        userNameEdit = newName
    }
    
    func detailPresenterUserDateChanges(_ newDate: Date) {
        userDateEdit = newDate
    }
    
    func detailPresenterUserTimeChanges(_ newTime: Date) {
        userTimeEdit = newTime
    }
}

extension DetailPresenter: DetailOutputInteractorProtocol {
    
    func detailUserDataFetched(user: User?, items: [DetailItem]) {
        DispatchQueue.main.async {
            self.user = user
            self.detailItems = items
        }
    }
    
    func detailProcessFinished(error: APIError?) {
        DispatchQueue.main.async {
            if let error = error {
                self.view?.detailViewError(error: error)
            } else {
                self.detailItems = []
                self.view?.detailViewPresentAlert(NSLocalizedString("ALERT_WARNING", comment: ""), NSLocalizedString("DETAIL_PROCESS_FINISHED", comment: ""))
            }
        }
    }
    
    func detailOutputError(error: APIError) {
        DispatchQueue.main.async {
            self.view?.detailViewError(error: error)
        }
    }
}
