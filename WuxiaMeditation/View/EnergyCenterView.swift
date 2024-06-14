//
//  EnergyCenterView.swift
//  WuxiaMeditation
//
//  Created by Austin's Macbook Pro M3 on 6/15/24.
//

import SwiftUI

struct EnergyCenterView: View {
    @State private var description = "자시子時입니다.\n오늘 하루를 돌아보며,\n운기조식을 통해\n탁한 기를 내보내세요."
    @State private var subDescription = "단전이 많이 탁합니다."
    var body: some View {
        VStack {
            Text("運氣調息")
                .font(.title3)
                .foregroundStyle(.white)
            Spacer()
            Text(description)
                .font(.customLargeTitle)
                .font(.system(size: 25, weight: .bold))
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .lineSpacing(6.0)
            Spacer()
            Text(subDescription)
                .font(.system(size: 16))
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .lineSpacing(4.0)
                .padding(.bottom, 40)
            LargeButtonView(title: "운기조식 시작") {
                
            }
        }
        .onAppear {
            for family: String in UIFont.familyNames {
                            print(family)
                            for names : String in UIFont.fontNames(forFamilyName: family){
                                print("=== \(names)")
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

#Preview {
    EnergyCenterView()
}
