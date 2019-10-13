//
//  APIRequestProtocol.swift
//  IUD
//
//  Created by Carlos Monfort on 09/10/2019.
//  Copyright © 2019 Carlos Monfort. All rights reserved.
//

import Foundation

protocol APIRequestProtocol {
    var path: APIEndPoint { get }
    var method: APIMethod { get }
}
