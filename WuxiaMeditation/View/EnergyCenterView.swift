//
//  EnergyCenterView.swift
//  WuxiaMeditation
//
//  Created by Austin's Macbook Pro M3 on 6/15/24.
//

import SwiftUI

struct EnergyCenterView: View {
    @State private var isMeditation = false
    @State private var isMeditationDoneOnTime = false
    @State private var eneryState: EneryState = .level0
    @State private var currentWuxiaTime: WuxiaTime = Date().wuxiaTime
    @State private var meditationSentence: MeditationSentence = dummyMeditationSentenceList[0]
    @State private var futureData: Date = Calendar.current.date(byAdding: .minute, value: 10, to: Date()) ?? Date()
    @State private var meditationTimeRemaining: String = ""
    @State private var timerCount: Int = 0
    
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
        }
        .onAppear {
            checkWuxiaTimeChanged()
            updateMeditaionSentence()
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
        Text(isMeditationDoneOnTime ? currentWuxiaTime.titleDescriptionAfterMeditation : currentWuxiaTime.titleDescriptionBeforeMeditation)
            .font(.customTitle)
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
        LargeButtonView(title: "운기조식 시작") {
            setMeditationStarted()
        }
    }
    
    @ViewBuilder
    var meditaionView: some View {
        VStack(spacing: 20) {
            Text(meditationSentence.sentence)
                .font(.customBody)
            Text(meditationSentence.author)
                .font(.customCaption)
        }
        .foregroundStyle(.white)
        .multilineTextAlignment(.center)
        .lineSpacing(6.0)
        
        Spacer()
        Text("일다경동안 운기조식을 합니다.")
            .font(.customBody)
            .foregroundStyle(.white)
            .multilineTextAlignment(.center)
            .lineSpacing(4.0)
            .padding(.bottom, 40)
        LargeButtonView(title: "\(meditationTimeRemaining) 뒤 종료") {
            setMeditationEnded()
        }
    }
}

private extension EnergyCenterView {
    func checkWuxiaTimeChanged() {
        let newDate = Date.now
        if currentWuxiaTime != newDate.wuxiaTime {
            isMeditationDoneOnTime = false
        }
        currentWuxiaTime = newDate.wuxiaTime
    }
    
    func setMeditationStarted() {
        withAnimation {
            futureData = Calendar.current.date(byAdding: .minute, value: 10, to: Date()) ?? Date()
            updateTimeRemaining()
            timerCount = 0
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                updateTimeRemaining()
                timerCount += 1
                if timerCount % 8 == 0 {
                    updateMeditaionSentence()
                }
            }
            isMeditation = true
        }
    }
    
    func setMeditationEnded() {
        withAnimation {
            isMeditationDoneOnTime = true
            isMeditation = false
        }
    }
    
    func updateTimeRemaining() {
        let remaining = Calendar.current.dateComponents([.minute, .second], from: Date(), to: futureData)
        let minute = remaining.minute ?? 0
        let second = remaining.second ?? 0
        meditationTimeRemaining = "\(minute)분 \(second)초 후"
    }
    
    func updateMeditaionSentence() {
        withAnimation {
            meditationSentence = dummyMeditationSentenceList.randomElement() ?? dummyMeditationSentenceList[0]
        }
    }
}

#Preview {
    EnergyCenterView()
}
