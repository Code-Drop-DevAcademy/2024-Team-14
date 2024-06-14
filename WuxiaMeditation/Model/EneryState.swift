//
//  EneryState.swift
//  WuxiaMeditation
//
//  Created by Austin's Macbook Pro M3 on 6/15/24.
//

import Foundation

enum EnergyState: Int {
    case level0
    case level1
    case level2
    case level3
    case level4
    
    var description: String {
        switch self {
        case .level0: "단전이 깨끗합니다."
        case .level1: "단전이 조금 탁해졌습니다."
        case .level2: "단전이 많이 탁합니다."
        case .level3: "단전이 요동치고 있습니다."
        case .level4: "주화입마 직전입니다.\n당장 운기조식이 필요합니다."
        }
    }
}
