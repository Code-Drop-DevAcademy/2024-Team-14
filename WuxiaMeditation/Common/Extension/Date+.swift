//
//  Date+.swift
//  WuxiaMeditation
//
//  Created by Austin's Macbook Pro M3 on 6/15/24.
//

import SwiftUI

extension Date {
    var wuxiaTime: WuxiaTime {
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        for wuxiaTime in WuxiaTime.allCases {
            if wuxiaTime.timeRange ~= hour {
                return wuxiaTime
            }
        }
        return .state0
    }
}
