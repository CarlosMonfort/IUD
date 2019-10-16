//
//  DetailPresenter.swift
//  IUD
//
//  Created by Carlos Monfort on 09/10/2019.
//  Copyright © 2019 Carlos Monfort. All rights reserved.
//

import UIKit

class DetailPresenter {
    
    // MARK: - Variables
    var view: DetailViewProtocol?
    var interactor: DetailInputInteractorProtocol?
    var wireframe: DetailWireframeProtocol?
    var user: User?
    var detailVC: DetailViewController!
    var userNameEdit: String?
    var userDateEdit: Date?
    var userTimeEdit: Date?
    
    func viewDidLoad() {
        detailVC.navigationItem.title = NSLocalizedString("DETAIL_TITLE", comment: "")
        setUpTableView()
        if let user = user {
            interactor?.detailInputGetUser(id: user.id)
        } else {
            interactor?.detailInputGetEmptyItems()
        }
        
    }
    
    func setUpTableView() {
        detailVC.tableView.delegate = detailVC
        detailVC.tableView.dataSource = detailVC
        detailVC.tableView.rowHeight = UITableView.automaticDimension
        detailVC.tableView.estimatedRowHeight = 70
        detailVC.tableView.tableFooterView = UIView()
        detailVC.tableView.register(DetailNameTableViewCell.nib, forCellReuseIdentifier: DetailNameTableViewCell.identifier)
        detailVC.tableView.register(DetailHourTableViewCell.nib, forCellReuseIdentifier: DetailHourTableViewCell.identifier)
        detailVC.tableView.register(DetailBirthdayTableViewCell.nib, forCellReuseIdentifier: DetailBirthdayTableViewCell.identifier)
    }
    
    func saveData() {
        interactor?.detailInputUpdateUser(currentUser: user, name: userNameEdit, date: userDateEdit, time: userTimeEdit)
    }
}

extension DetailPresenter: DetailPresenterProtocol {
    
    func detailPresenterViewDidLoad(from view: DetailViewController) {
        detailVC = view
        viewDidLoad()
    }
    
    func detailPresenterBarBtDeletePressed() {
        guard let user = user else { return }
        interactor?.detailInputDeleteUser(id: user.id)
    }
    
    func detailPresenterBarBtUndoPressed() {
        guard let user = user else { return }
        detailUserDataFetched(user: user, items: detailVC.detailItems)
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
            self.view?.detailViewUpdateItems(items: items)
        }
    }
    
    func detailProcessFinished(error: APIError?) {
        DispatchQueue.main.async {
            if let error = error {
                self.view?.detailViewError(error: error)
            } else {
                self.view?.detailViewUpdateItems(items: [])
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
