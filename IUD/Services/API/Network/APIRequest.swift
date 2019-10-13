//
//  APIRequest.swift
//  IUD
//
//  Created by Carlos Monfort on 09/10/2019.
//  Copyright © 2019 Carlos Monfort. All rights reserved.
//

import Foundation

class APIRequest {
    
    let method: APIMethod
    let path: String
    var queryItems: [URLQueryItem]?
    var headers: [APIHeader]?
    var body: Data?
    
    init(method: APIMethod, path: String) {
        self.method = method
        self.path = path
    }
    
    init(method: APIMethod, path: String, user: User) throws {
        self.method = method
        self.path = path
        let header1 = APIHeader(field: "Content-Type", value: "application/json")
        let header2 = APIHeader(field: "Accept", value: "application/json")
        headers = [header1, header2]
        self.body = try JSONEncoder().encode(user)
    }
}
