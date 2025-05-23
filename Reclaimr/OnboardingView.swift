//
//  OnboardingView.swift
//  Reclaimr
//
//  Created by ben on 16/5/25.
//

import SwiftUI

struct OnboardingView: View {
    @State private var screenTimeLimit: Int = 0
    @State private var productiveGoal: Int = 0

    let onFinish: () -> Void

    var body: some View {
        VStack(spacing: 30) {
            Text("Welcome to Reclaimr!")
                .font(.largeTitle)
                .bold()

            Stepper("Daily Screen Time Limit: \(screenTimeLimit)h", value: $screenTimeLimit, in: 1...24)
            Stepper("Productive Goal: \(productiveGoal)h", value: $productiveGoal, in: 1...24)

            Button("Finish Setup") {
                let defaults = UserDefaults(suiteName: "group.com.nebitrams.Reclaimr")
                defaults?.set(screenTimeLimit, forKey: "dailyScreenTimeLimit")
                defaults?.set(productiveGoal, forKey: "dailyProductiveGoal")
                defaults?.set(true, forKey: "hasCompletedSetup")

                onFinish()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}
