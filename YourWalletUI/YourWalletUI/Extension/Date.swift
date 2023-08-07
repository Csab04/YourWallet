//
//  Date.swift
//  YourWalletUI
//
//  Created by Csaba Otvos on 19.02.2023.
//

import Foundation
import SwiftUI
extension Date {
    var displayFormatForSectiomHeader:String {
        self.formatted(
            .dateTime
                .month(.wide)
                .day(.twoDigits)
            
            )
    }
}
 

extension DateFormatter{
    static let allNumeric : DateFormatter = {
        let formater = DateFormatter()
        
        formater.dateFormat = "MM.dd.yyyy"
        
        return formater
    }()
}

extension String {
    func dateParsed() -> Date {
        guard let parseDate = DateFormatter.allNumeric.date(from: self) else{return Date()
        }
        return parseDate
    }
}
 


 
extension Double {
    func roundTo2Digits() -> Double {
        return (self * 100).rounded() / 100
    }
}
