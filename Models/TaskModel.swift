//
//  TaskModel.swift
//  Reclaimr
//
//  Created by ben on 12/5/25.
//

import Foundation

class TaskModel: Identifiable, Codable {
    var id = UUID()
    var name: String
    var rewardMinutes: Int
    var startTime: Date? = nil

    init(name: String, rewardMinutes: Int) {
        self.name = name
        self.rewardMinutes = rewardMinutes
    }

    func startTask() {
        startTime = Date()
    }

    var isRunning: Bool {
        return startTime != nil
    }
}
