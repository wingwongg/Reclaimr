//
//  TaskListModel.swift
//  Reclaimr
//
//  Created by ben on 12/5/25.
//

import Foundation

private let _TaskListModel = TaskListModel()

class TaskListModel : ObservableObject {
    class var shared: TaskListModel {
        return _TaskListModel
    }
    @Published var tasks: [TaskModel] = []
    
    init() {
        tasks.append(TaskModel(name: "Run", rewardMinutes: 30))
    }
    
    func addTask(_ task: TaskModel) {
        tasks.append(task)
    }
    
    func editTask(_ task: TaskModel, _ name: String, _ rewardMinutes: Int) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index] = TaskModel(name: name, rewardMinutes: rewardMinutes)
        }
    }
}
