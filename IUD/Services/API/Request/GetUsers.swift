//
//  GetUsers.swift
//  IUD
//
//  Created by Carlos Monfort on 10/10/2019.
//  Copyright © 2019 Carlos Monfort. All rights reserved.
//

import UIKit

struct GetUsers: APIRequestProtocol {
    
    var path: APIEndPoint {
        return .noParams
    }
    
    var method: APIMethod {
        return .get
    }
}
