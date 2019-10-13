//
//  DetailItem.swift
//  IUD
//
//  Created by Carlos Monfort on 11/10/2019.
//  Copyright © 2019 Carlos Monfort. All rights reserved.
//

import Foundation

enum DetailItemType {
    case name, birthday, hour
}

protocol DetailItem {
    var type: DetailItem { get }
    var rowCount: Int { get }
    var sectionTitle: String  { get }
}

extension DetailItem {
    var rowCount: Int {
        return 1
    }
    
    var sectionTitle: String {
        return ""
    }
}
