//
//  DetailBirthdayTableViewCell.swift
//  IUD
//
//  Created by Carlos Monfort on 11/10/2019.
//  Copyright © 2019 Carlos Monfort. All rights reserved.
//

import UIKit

protocol DetailBirthdayCellProtocol {
    func detailBirthdayCellDateChange(_ date: Date)
}

class DetailBirthdayTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlet
    @IBOutlet weak var textField: UITextField!
    
    // MARK: - Variables
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    var date: Date! {
        didSet {
            setUpCell()
        }
    }
    
    var datePicker: UIDatePicker?
    var delegate: DetailBirthdayCellProtocol?
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUpCell() {
        createDatePicker()
        updateTextField()
    }
    
    // MARK: - Date Picker
    func createDatePicker() {
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.date = date
        datePicker?.frame = CGRect(x: 0, y: self.frame.maxY - self.frame.height, width: self.frame.width, height: 200)
        
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        let space = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(doneDatePickerPressed))

        toolBar.setItems([space, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        
        textField.inputAccessoryView = toolBar
    }
    
    @objc func doneDatePickerPressed(){
        updateTextField()
        guard let birthday = datePicker?.date else { return }
        delegate?.detailBirthdayCellDateChange(birthday)
        self.endEditing(true)
    }
    
    // MARK: - Textfield
    func updateTextField() {
        let font = UIFont.preferredFont(forTextStyle: .title2)
        let attributes = [NSAttributedString.Key.font: font]
        textField.attributedText = NSAttributedString(string: datePicker?.date.toFormattedString(dateFormat: .dayComplete) ?? date.toFormattedString(dateFormat: .dayComplete), attributes: attributes)
        textField.inputView = datePicker
    }
}
