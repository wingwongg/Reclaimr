//
//  TaskModel.swift
//  Reclaimr
//
//  Created by ben on 12/5/25.
//

import Foundation

class TaskModel: ObservableObject, Identifiable {
    let id = UUID()
    @Published var name: String
    @Published var rewardMinutes: Int
    @Published var startTime: Date? = nil

    init(name: String, rewardMinutes: Int) {
        self.name = name
        self.rewardMinutes = rewardMinutes
    }

    func startTask() {
        startTime = Date()
    }
    
    func editTask(name: String, rewardMinutes: Int) {
        self.name = name
        self.rewardMinutes = rewardMinutes
    }

    var isRunning: Bool {
        return startTime != nil
    }
}
