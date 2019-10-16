//
//  MainPresenter+Extensions.swift
//  IUD
//
//  Created by Carlos Monfort Gómez on 16/10/2019.
//  Copyright © 2019 Carlos Monfort. All rights reserved.
//

import UIKit

extension MainPresenter: MainPresenterProtocol {
    
    func mainPresenterViewDidLoad(from view: MainViewController) {
        viewDidLoad(from: view)
    }
    
    func mainPresenterViewWillAppear() {
        mainPresenterGetUsers()
    }
    
    func mainPresenterGetUsers() {
        interactor?.mainInputGetUsers()
    }
    
    func mainPresenterPresentDetail(from user: User?) {
        wireframe?.mainWirePresentDetail(with: user)
    }
}

extension MainPresenter: MainOutputInteractorProtocol {
    
    func mainOutputUsersDataFetched(users: [User]) {
        DispatchQueue.main.async {
            self.usersList = users
        }
    }
    
    func mainOutputError(error: APIError) {
        DispatchQueue.main.async {
            self.view?.mainViewError(error: error)
        }
    }
}

extension MainPresenter: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = usersList[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier, for: indexPath) as? UserTableViewCell else { view?.mainViewError(error: .custom(code: 0, message: "Cell Error")); return UITableViewCell()}
        cell.user = user
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mainPresenterPresentDetail(from: usersList[indexPath.row])
        tableView.deselectRow(at:indexPath, animated: true)
    }
}
