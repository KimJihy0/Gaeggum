//
//  YearMonth.swift
//  Gaeggum
//
//  Created by Jihyo on 2022/05/17.
//

import Foundation

struct YearMonth: Codable, Comparable {
    
    var year: Int
    var month: Int
    var string: String {
        return String(self.year) + "." + String(format: "%2d", self.month) + "."
    }
    
    init(_ year: Int = Calendar.current.component(.year, from: Date()),
         _ month: Int = Calendar.current.component(.month, from: Date())) {
        self.year = year
        self.month = month
    }
    
    static func < (lhs: YearMonth, rhs: YearMonth) -> Bool {
        return lhs.year < rhs.year || (lhs.year == rhs.year && lhs.month < rhs.month)
    }
}

