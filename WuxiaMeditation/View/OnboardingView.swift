//
//  OnboardingView.swift
//  WuxiaMeditation
//
//  Created by Austin's Macbook Pro M3 on 6/15/24.
//

import SwiftUI

struct OnboardingView: View {
    @AppStorage("isOnboarding") private var isOnboarding: Bool = true
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            Text("運氣調息")
                .foregroundStyle(.white)
                .font(.system(size: 34))
                .padding(.bottom, 16)
            Text("일과 삶의 마음 지킴 명상앱\n운기조식運氣調息")
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .font(.system(size: 16))
                .lineSpacing(6)
            Spacer()
            LargeButtonView(title: "시작") {
                withAnimation {
                    isOnboarding = false
                }
            }
        }
        .background(
            Image(.background)
                .ignoresSafeArea(edges: .top)
        )
        .padding(16)
        
    }
}

#Preview {
    OnboardingView()
}
