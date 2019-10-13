//
//  DetailNameTableViewCell.swift
//  IUD
//
//  Created by Carlos Monfort on 11/10/2019.
//  Copyright © 2019 Carlos Monfort. All rights reserved.
//

import UIKit

protocol DetailNameCellProtocol {
    func detailNameCellUserNameChange(_ text: String)
}

class DetailNameTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlet
    @IBOutlet weak var textField: UITextField!
    
    // MARK: - Variables
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    var name: String! {
        didSet {
            setUpCell()
        }
    }
    
    var delegate: DetailNameCellProtocol?
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUpCell() {
        //textField.delegate = self
        let font = UIFont.preferredFont(forTextStyle: .title2)
        let attributes = [NSAttributedString.Key.font: font]
        textField.attributedText = NSAttributedString(string: name, attributes: attributes)
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        delegate?.detailNameCellUserNameChange(text)
    }
}
