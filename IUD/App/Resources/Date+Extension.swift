//
//  Date+Extension.swift
//  IUD
//
//  Created by Carlos Monfort on 09/10/2019.
//  Copyright © 2019 Carlos Monfort. All rights reserved.
//

import Foundation

enum DateFormat: String {
    
    case dayComplete = "dd-MM-yyyy"
    case time = "HH:mm"
    
    func value() -> String {
        return self.rawValue
    }
}

extension Date {
    
    func toFormattedString(dateFormat: DateFormat) -> String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = dateFormat.rawValue
        let formattedDate = dateFormatterPrint.string(from: self)
        return formattedDate
    }
}
