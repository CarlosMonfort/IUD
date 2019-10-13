//
//  UserTableViewCell.swift
//  IUD
//
//  Created by Carlos Monfort on 09/10/2019.
//  Copyright © 2019 Carlos Monfort. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbBirthday: UILabel!
    
    // MARK: - Variables
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    var user: User! {
        didSet {
            setUpCell()
        }
    }
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setUpCell() {
        configLabel(label: lbName, with: user?.name ?? "No name")
        let dateToString = user.birthdate.toFormattedString(dateFormat: .dayComplete)
        configLabel(label: lbBirthday, with: dateToString)
    }
    
    func configLabel(label: UILabel, with text: String) {
        label.text = text
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
    }
}
