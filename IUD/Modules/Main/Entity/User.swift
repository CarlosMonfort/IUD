//
//  User.swift
//  IUD
//
//  Created by Carlos Monfort on 09/10/2019.
//  Copyright © 2019 Carlos Monfort. All rights reserved.
//

import Foundation

struct User: Codable {
    
    let id: Int
    var name: String?
    var birthdate: Date
}
