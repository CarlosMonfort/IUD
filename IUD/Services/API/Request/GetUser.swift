//
//  GetUser.swift
//  IUD
//
//  Created by Carlos Monfort on 11/10/2019.
//  Copyright © 2019 Carlos Monfort. All rights reserved.
//

import Foundation

struct GetUser: APIRequestProtocol {
    
    var path: APIEndPoint
    
    var method: APIMethod {
        return .get
    }
}
