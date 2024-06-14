//
//  EnergyCenterView.swift
//  WuxiaMeditation
//
//  Created by Austin's Macbook Pro M3 on 6/15/24.
//

import SwiftUI

struct EnergyCenterView: View {
    @State private var isMeditation = false
    @State private var eneryState: EneryState = .level4
    @State private var currentWuxiaTime: WuxiaTime = Date.now.wuxiaTime
    
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
        
        Text(currentWuxiaTime.titleDescription)
            .font(.customTitle)
            .font(.system(size: 25, weight: .bold))
            .foregroundStyle(.white)
            .multilineTextAlignment(.center)
            .lineSpacing(6.0)
        Spacer()
        Text(eneryState.description)
            .font(.customBody)
            .foregroundStyle(.white)
            .multilineTextAlignment(.center)
            .lineSpacing(4.0)
            .padding(.bottom, 40)
    }
    
    @ViewBuilder
    var meditaionView: some View {
        Text(currentWuxiaTime.titleDescription)
            .font(.customTitle)
            .font(.system(size: 25, weight: .bold))
            .foregroundStyle(.white)
            .multilineTextAlignment(.center)
            .lineSpacing(6.0)
        Spacer()
        Text(eneryState.description)
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
