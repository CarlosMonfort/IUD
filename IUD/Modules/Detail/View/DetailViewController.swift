//
//  DetailViewController.swift
//  IUD
//
//  Created by Carlos Monfort on 11/10/2019.
//  Copyright © 2019 Carlos Monfort. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var barBtDelete: UIBarButtonItem!
    @IBOutlet weak var barBtUndo: UIBarButtonItem!
    @IBOutlet weak var barBtSave: UIBarButtonItem!
    
    // MARK: - Variables
    var presenter: DetailPresenterProtocol?
    var datePicker: UIDatePicker?
    
    // MARK: - Life Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.detailPresenterViewDidLoad(from: self)
    }
    
    // MARK: - IBActions
    @IBAction func barBtDeletePressed(_ sender: Any) {
        presenter?.detailPresenterBarBtDeletePressed()
    }
    
    @IBAction func barBtUndoPressed(_ sender: Any) {
        presenter?.detailPresenterBarBtUndoPressed()
    }
    
    @IBAction func barBtSavePressed(_ sender: Any) {
        presenter?.detailPresenterBarBtSavePressed()
    }
}

extension DetailViewController: DetailViewProtocol {
    
    func detailViewUpdateItems() {
        tableView.reloadData()
    }
    
    func detailViewPresentAlert(_ title: String, _ description: String) {
        presentAlertAndGoBack(title: NSLocalizedString("ALERT_WARNING", comment: ""), message: description)
    }
    
    func detailViewError(error: APIError) {
        presentAlert(title: NSLocalizedString("ALERT_ERROR", comment: ""), message: error.localizedDescription)
    }
}
