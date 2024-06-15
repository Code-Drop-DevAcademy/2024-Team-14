//
//  EnergyCenterView.swift
//  WuxiaMeditation
//
//  Created by Austin's Macbook Pro M3 on 6/15/24.
//

import SwiftUI

private let standardMinute: Int = 1
struct EnergyCenterView: View {
    enum MeditationState {
        case notStarted
        case preparing
        case progressing
    }
    @State private var meditationState: MeditationState = .notStarted
    @State private var isMeditationDoneOnTime = false
    @State private var isShowEndMeditationAlert = false
    @State private var energyState: EnergyState = .level0
    @State private var currentWuxiaTime: WuxiaTime = Date().wuxiaTime
    @State private var meditationSentence: MeditationSentence = dummyMeditationSentenceList[0]
    @State private var futureData: Date = Calendar.current.date(byAdding: .minute, value: standardMinute, to: Date()) ?? Date()
    @State private var meditationTimeRemaining: String = ""
    @State private var timerCount: Int = 0
    
    var body: some View {
        VStack {
            Text("運氣調息")
                .font(.title3)
                .foregroundStyle(.white)
            Spacer()
            switch meditationState {
            case .notStarted: energyStateView
            case .progressing: meditaionView
            default: HStack { Spacer() }
            }
        }
        .padding()
        .alert(isPresented: $isShowEndMeditationAlert) {
            Alert(
                title: Text("운기조식을 종료합니다."),
                primaryButton:
                        .destructive(Text("종료"), action: {
                    setMeditationEnded()
                }),
                secondaryButton: .cancel(Text("취소")))
        }
        .background {
            PlayerView(energyState: $energyState)
                .ignoresSafeArea()
                .onAppear {
                    AudioPlayManager.shared.playSound(sound: "meditation")
                }
        }
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
        Text(energyState.description)
            .font(.customBody)
            .foregroundStyle(.white)
            .multilineTextAlignment(.center)
            .lineSpacing(4.0)
            .padding(.bottom, 40)
        LargeButtonView(title: "운기조식 시작", energyState: energyState) {
            setMeditationStarted()
        }
    }
    
    @ViewBuilder
    var meditaionView: some View {
        VStack(spacing: 20) {
            Text(meditationSentence.sentence)
                .font(.customTitle3)
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
        LargeButtonView(title: isFinishedMeditation ? "운기조식 종료" : "\(meditationTimeRemaining) 뒤 종료", color: .white.opacity(isFinishedMeditation ? 1 : 0.5), energyState: energyState) {
            isShowEndMeditationAlert = true
        }
    }
}

private extension EnergyCenterView {
    var isFinishedMeditation: Bool {
        standardMinute * 60 > timerCount ? false : true
    }
    
    func checkWuxiaTimeChanged() {
        let newDate = Date.now
        if currentWuxiaTime != newDate.wuxiaTime {
            isMeditationDoneOnTime = false
        }
        currentWuxiaTime = newDate.wuxiaTime
    }
    
    func setMeditationStarted() {
        withAnimation {
            futureData = Calendar.current.date(byAdding: .minute, value: standardMinute, to: Date()) ?? Date()
            updateTimeRemaining()
            timerCount = 0
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                updateTimeRemaining()
                timerCount += 1
                if timerCount % 10 == 0 {
                    updateMeditaionSentence()
                }
            }
            meditationState = .preparing
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation {
                meditationState = .progressing
            }
        }
    }
    
    func setMeditationEnded() {
        withAnimation {
            calculateEnergyLevel()
            isMeditationDoneOnTime = true
            meditationState = .preparing
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation {
                meditationState = .notStarted
            }
        }
    }
    
    func calculateEnergyLevel() {
        if timerCount > standardMinute * 60 / 2 {
            energyState = EnergyState(rawValue: energyState.rawValue - 1 >= 0 ? energyState.rawValue - 1  : 0) ?? energyState
        } else if timerCount > standardMinute * 60 {
            if energyState.rawValue - 2 >= 0 {
                energyState = EnergyState(rawValue: energyState.rawValue - 2) ?? energyState
            } else if energyState.rawValue - 1 >= 0 {
                energyState = EnergyState(rawValue: energyState.rawValue - 1) ?? energyState
            }
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
