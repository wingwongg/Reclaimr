//
//  GoalsSettingView.swift
//  Reclaimr
//
//  Created by ben on 9/5/25.
//

import SwiftUI

struct GoalsSettingView : View {
    @GroupAppStorage("dailyScreenTimeLimit", suiteName: "group.com.nebitrams.Reclaimr") private var dailyLimit: Int = 0
    @GroupAppStorage("dailyProductiveGoal", suiteName: "group.com.nebitrams.Reclaimr") private var dailyGoal: Int = 0

    var body: some View {
        VStack {
            VStack(spacing: 20) {
                Text("Daily Screen Time Limit")
                    .font(.title2)
                    .bold()
                
                Text("\(dailyLimit) hour\(dailyLimit == 1 ? "" : "s")")
                    .font(.largeTitle)
                
                Stepper(value: $dailyLimit, in: 0...24, step: 1) {
                    Text("Set daily limit")
                }
                
            }
            .padding()
            
            VStack(spacing: 20) {
                Text("Daily Productive Hours")
                    .font(.title2)
                    .bold()
                
                Text("\(dailyGoal) hour\(dailyGoal == 1 ? "" : "s")")
                    .font(.largeTitle)
                
                Stepper(value: $dailyGoal, in: 0...24, step: 1) {
                    Text("Set daily goals")
                }
                
                Text("These preferences are saved automatically.")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding()
            Spacer()
        }
    }
}

struct GoalsSettingView_Previews: PreviewProvider {
    static var previews: some View {
        GoalsSettingView()
    }
}
