//
//  TaskRowView.swift
//  Reclaimr
//
//  Created by ben on 13/5/25.
//

import SwiftUI

struct TaskRowView : View {
    var currentTask: TaskModel
    
    var body: some View {
        HStack(alignment: .center) {
                Text(currentTask.name).font(.headline)
            Spacer()
            VStack() {
                Text("Points: 100")
                Text("Time: \(currentTask.rewardMinutes) min")
            }
            .font(.caption2)
        }
    }
}
    
#Preview {
    TaskRowView(currentTask: TaskModel(name: "Run", rewardMinutes: 30))
}
