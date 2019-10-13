//
//  BirthdayItem.swift
//  IUD
//
//  Created by Carlos Monfort on 11/10/2019.
//  Copyright © 2019 Carlos Monfort. All rights reserved.
//

import Foundation

class BirthdayItem: DetailItem {
    
    var type: DetailItemType {
        return .birthday
    }
    
    var date: Date
    
    init(_ birthday: Date) {
        self.date = birthday
    }
}
