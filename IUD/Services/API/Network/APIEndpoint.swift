//
//  APIEndpoint.swift
//  IUD
//
//  Created by Carlos Monfort on 09/10/2019.
//  Copyright © 2019 Carlos Monfort. All rights reserved.
//

import Foundation

enum APIEndPoint: String {
    
    case noParams = ""
    case id = "/%@"
    
    func value() -> String {
        return self.rawValue
    }
}
