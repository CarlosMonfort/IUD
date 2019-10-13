//
//  DetailHourTableViewCell.swift
//  IUD
//
//  Created by Carlos Monfort on 11/10/2019.
//  Copyright © 2019 Carlos Monfort. All rights reserved.
//

import UIKit

protocol DetailHourCellProtocol {
    func detailHourCellTimeChange(_ time: Date)
}

class DetailHourTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlet
    @IBOutlet weak var textField: UITextField!
    
    // MARK: - Variables
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    var time: Date! {
        didSet {
            setUpCell()
        }
    }
    
    var datePicker: UIDatePicker?
    var delegate: DetailHourCellProtocol?
    
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
        datePicker?.datePickerMode = .time
        datePicker?.date = time
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
        guard let time = datePicker?.date else { return }
        delegate?.detailHourCellTimeChange(time)
        self.endEditing(true)
    }
    
    // MARK: - Textfield
    func updateTextField() {
        let font = UIFont.preferredFont(forTextStyle: .title2)
        let attributes = [NSAttributedString.Key.font: font]
        textField.attributedText = NSAttributedString(string: datePicker?.date.toFormattedString(dateFormat: .time) ?? time.toFormattedString(dateFormat: .time), attributes: attributes)
        textField.inputView = datePicker
    }
}
