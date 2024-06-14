//
//  EnergyCenterView.swift
//  WuxiaMeditation
//
//  Created by Austin's Macbook Pro M3 on 6/15/24.
//

import SwiftUI

enum WuxiaTime {
    case state0
    case state1
    case state2
    case state3
    case state4
    case state5
    case state6
    case state7
    case state8
    case state9
    case state10
    case state11
    
    var timeDescription: String {
        switch self {
        case .state0: "자시(子時)"
        case .state1: "축시子時"
        case .state2: "인시寅時"
        case .state3: "묘시卯時"
        case .state4: "진시(辰時)"
        case .state5: "사시(巳時)"
        case .state6: "오시(午時)"
        case .state7: "미시(未時)"
        case .state8: "신시(申時)"
        case .state9: "유시(酉時)"
        case .state10: "술시(戌時)"
        case .state11: "해시(亥時)"
            
        }
    }
}


struct EnergyCenterView: View {
    @State private var isMeditation = false
    @State private var description = "자시子時입니다.\n오늘 하루를 돌아보며,\n운기조식을 통해\n탁한 기를 내보내세요."
    @State private var subDescription = "단전이 많이 탁합니다."
    
    var body: some View {
        VStack {
            Text("運氣調息")
                .font(.title3)
                .foregroundStyle(.white)
            Spacer()
            if isMeditation {
                meditaionView
            } else {
                energyStateView
            }
            LargeButtonView(title: "운기조식 시작") {
                withAnimation {
                    isMeditation = true
                }
            }
        }
        .background {
            Image(.background)
                .ignoresSafeArea(edges: .top)
        }
        .padding()
    }
}

extension EnergyCenterView {
    
    @ViewBuilder
    var energyStateView: some View {
        
        Text(description)
            .font(.customTitle)
            .font(.system(size: 25, weight: .bold))
            .foregroundStyle(.white)
            .multilineTextAlignment(.center)
            .lineSpacing(6.0)
        Spacer()
        Text(subDescription)
            .font(.customBody)
            .foregroundStyle(.white)
            .multilineTextAlignment(.center)
            .lineSpacing(4.0)
            .padding(.bottom, 40)
    }
    
    @ViewBuilder
    var meditaionView: some View {
        Text(description)
            .font(.customTitle)
            .font(.system(size: 25, weight: .bold))
            .foregroundStyle(.white)
            .multilineTextAlignment(.center)
            .lineSpacing(6.0)
        Spacer()
        Text(subDescription)
            .font(.customBody)
            .foregroundStyle(.white)
            .multilineTextAlignment(.center)
            .lineSpacing(4.0)
            .padding(.bottom, 40)
    }
}

#Preview {
    EnergyCenterView()
}
