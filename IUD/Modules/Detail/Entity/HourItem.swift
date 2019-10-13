//
//  HourItem.swift
//  IUD
//
//  Created by Carlos Monfort on 11/10/2019.
//  Copyright © 2019 Carlos Monfort. All rights reserved.
//

import Foundation

class HourItem: DetailItem {
    
    var type: DetailItemType {
        return .hour
    }
    
    var time: Date
    
    init(_ time: Date) {
        self.time = time
    }
}
