//
//  APIResponse.swift
//  IUD
//
//  Created by Carlos Monfort on 09/10/2019.
//  Copyright © 2019 Carlos Monfort. All rights reserved.
//

import Foundation

struct APIResponse: Decodable {
    
    let code: Int
    let headers: String
    let body: [User]
}
