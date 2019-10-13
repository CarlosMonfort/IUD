//
//  DetailViewController+Extensions.swift
//  IUD
//
//  Created by Carlos Monfort on 11/10/2019.
//  Copyright © 2019 Carlos Monfort. All rights reserved.
//

import UIKit

extension DetailViewController: DetailViewProtocol {
    
    func detailViewUpdateItems(items: [DetailItem]) {
        detailItems = items
    }
    
    func detailViewPresentAlert(_ title: String, _ description: String) {
        presentAlertAndGoBack(title: NSLocalizedString("ALERT_WARNING", comment: ""), message: description)
    }
    
    func detailViewError(error: APIError) {
        presentAlert(title: NSLocalizedString("ALERT_ERROR", comment: ""), message: error.localizedDescription)
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return detailItems.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return detailItems[section].sectionTitle
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailItems[section].rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        let item = detailItems[indexPath.section]
        switch item.type {
        case .name:
            guard let item = item as? NameItem, let nameCell = tableView.dequeueReusableCell(withIdentifier: DetailNameTableViewCell.identifier, for: indexPath) as? DetailNameTableViewCell else { return cell }
            nameCell.name = item.name
            nameCell.delegate = self
            cell = nameCell
        case .birthday:
            guard let item = item as? BirthdayItem, let birthCell = tableView.dequeueReusableCell(withIdentifier: DetailBirthdayTableViewCell.identifier, for: indexPath) as? DetailBirthdayTableViewCell else { return cell }
            birthCell.date = item.date
            birthCell.delegate = self
            cell = birthCell
        case .hour:
            guard let item = item as? HourItem, let timeCell = tableView.dequeueReusableCell(withIdentifier: DetailHourTableViewCell.identifier, for: indexPath) as? DetailHourTableViewCell else { return cell }
            timeCell.time = item.time
            timeCell.delegate = self
            cell = timeCell
        }
        cell.selectionStyle = .none
        return cell
    }
}

extension DetailViewController: DetailNameCellProtocol {
    
    func detailNameCellUserNameChange(_ text: String) {
        presenter?.detailPresenterUserNameChanges(text)
    }
}

extension DetailViewController: DetailBirthdayCellProtocol {
    
    func detailBirthdayCellDateChange(_ date: Date) {
        presenter?.detailPresenterUserDateChanges(date)
    }
}

extension DetailViewController: DetailHourCellProtocol {
    
    func detailHourCellTimeChange(_ time: Date) {
        presenter?.detailPresenterUserTimeChanges(time)
    }
}
