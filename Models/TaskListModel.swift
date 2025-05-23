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
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let tasksKey = "storedTasks"
    
    init() {
        tasks.append(TaskModel(name: "Go for a run", rewardMinutes: 45))
        tasks.append(TaskModel(name: "Read a book", rewardMinutes: 30))
    }

    func saveTasks() {
        do {
            let data = try JSONEncoder().encode(tasks)
            UserDefaults.standard.set(data, forKey: tasksKey)
        } catch {
            print("Failed to encode tasks: \(error)")
        }
    }

    func loadTasks() {
        guard let data = UserDefaults.standard.data(forKey: tasksKey) else {
            return
        }

        do {
            tasks = try JSONDecoder().decode([TaskModel].self, from: data)
        } catch {
            print("Failed to decode tasks: \(error)")
        }
    }
    
    func addTask(_ task: TaskModel) {
        tasks.append(task)
        saveTasks()
    }
    
    func editTask(_ task: TaskModel, _ name: String, _ rewardMinutes: Int) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index] = TaskModel(name: name, rewardMinutes: rewardMinutes)
        }
        saveTasks()
    }
    
    func deleteTask(_ task: TaskModel) {
        tasks.remove(at: tasks.firstIndex(where: { $0.id == task.id })!)
        saveTasks()
    }
}
