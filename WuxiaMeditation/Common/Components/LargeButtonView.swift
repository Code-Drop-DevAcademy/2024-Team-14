//
//  LargeButtonView.swift
//  WuxiaMeditation
//
//  Created by Austin's Macbook Pro M3 on 6/15/24.
//

import SwiftUI

struct LargeButtonView: View {
    var title: String
    var color: Color = .white
    var energyState: EnergyState = .level0
    var completion: () -> Void
    
    var backgroundColor: Color {
        switch energyState {
        case .level0: .primaryGreen
        case .level1: .primaryBlue
        case .level2: .primaryBrown
        case .level3: .primaryRed
        case .level4: .primaryGray
        }
    }
    
    var body: some View {
        Button {
            completion()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 12.0)
                    .fill(backgroundColor)
                    .frame(width: .infinity, height: 50)
                Text(title)
                    .font(.customBody)
                    .foregroundStyle(color)
            }
        }
    }
}

#Preview {
    LargeButtonView(title: "시작") {
        print("start")
    }
}
