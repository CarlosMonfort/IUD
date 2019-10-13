//
//  APIError.swift
//  IUD
//
//  Created by Carlos Monfort on 09/10/2019.
//  Copyright © 2019 Carlos Monfort. All rights reserved.
//

import Foundation

enum APIError: Error {
    
    case unexpectedError
    case timeout
    case invalidURL
    case requestFailed
    case decodingFailure
    case noData
    case sessionFail
    case custom(code: Int, message: String)
    
    var localizedDescription: String {
        switch self {
        case .unexpectedError:
            return NSLocalizedString("ERROR_UNEXPECTED", comment: "")
        case .timeout:
            return NSLocalizedString("ERROR_TIMEOUT", comment: "")
        case .invalidURL:
            return NSLocalizedString("ERROR_INVALID_URL", comment: "")
        case .requestFailed:
            return NSLocalizedString("ERROR_REQUEST_FAILED", comment: "")
        case .decodingFailure:
            return NSLocalizedString("ERROR_DECODING_FAILURE", comment: "")
        case .noData:
            return NSLocalizedString("ERROR_NODATA", comment: "")
        case .sessionFail:
            return NSLocalizedString("ERROR_SESSION_FAIL", comment: "")
        case .custom(code: _, message: let message):
            return message
        }
    }
    
    var code: Int {
        switch self {
        case .custom(code: let code, message: _):
            return code
        default:
            return 1000
        }
    }
}
