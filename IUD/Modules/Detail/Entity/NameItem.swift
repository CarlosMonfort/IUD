//
//  NameItem.swift
//  IUD
//
//  Created by Carlos Monfort on 11/10/2019.
//  Copyright © 2019 Carlos Monfort. All rights reserved.
//

import Foundation

class NameItem: DetailItem {
    
    var type: DetailItemType {
        return .name
    }
    
    var name: String
    
    init(_ name: String) {
        self.name = name
    }
}
