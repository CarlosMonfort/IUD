//
//  MainViewController+Extensions.swift
//  IUD
//
//  Created by Carlos Monfort on 09/10/2019.
//  Copyright © 2019 Carlos Monfort. All rights reserved.
//

import UIKit

extension MainViewController: MainViewProtocol {
    
    func mainViewUpdateUsers(with users: [User]) {
        usersList = users
    }
    
    func mainViewError(error: APIError) {
        presentAlert(title: NSLocalizedString("ALERT_ERROR", comment: ""), message: error.localizedDescription)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = usersList[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier, for: indexPath) as? UserTableViewCell else { mainViewError(error: .custom(code: 0, message: "Cell Error")); return UITableViewCell()}
        cell.user = user
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.mainPresenterPresentDetail(from: usersList[indexPath.row])
        tableView.deselectRow(at:indexPath, animated: true)
    }
}
