//
//  EditTaskPopupView.swift
//  Reclaimr
//
//  Created by ben on 12/5/25.
//

import SwiftUI

struct EditTaskPopupView: View {
    @Binding var isPresented: Bool
    var currentTask: TaskModel
    var onConfirm: (String, Int) -> Void

    @State private var taskName: String = ""
    @State private var rewardTime: String = ""


    var body: some View {
        ZStack {
            Color.black.opacity(0.3)
                .ignoresSafeArea()

            VStack(spacing: 20) {
                Text("Edit Task")
                    .font(.headline)

                VStack(alignment: .leading, spacing: 12) {
                    Text("Task Name")
                        .font(.subheadline)
                    TextField("\(currentTask.name)", text: $taskName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    Text("Time Reward (in minutes)")
                        .font(.subheadline)
                    TextField("\(currentTask.rewardMinutes)", text: $rewardTime)
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding(.horizontal)

                HStack {
                    Button("Cancel") {
                        isPresented = false
                        taskName = ""
                        rewardTime = ""
                    }
                    .padding(.leading, 30)
                    .foregroundColor(.red)
                    
                    Spacer()

                    Button("Confirm") {
                        if let time = Int(rewardTime), !taskName.isEmpty {
                            onConfirm(taskName, time)
                            isPresented = false
                            taskName = ""
                            rewardTime = ""
                        }
                        // Optionally add validation feedback here
                    }
                    .padding(.trailing, 30)
                    .foregroundColor(.blue)
                }
                .padding(.horizontal)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(16)
            .shadow(radius: 10)
            .frame(maxWidth: 320)
        }
        .animation(.easeInOut, value: isPresented)
    }
}

struct EditTaskPopupView_Preview : PreviewProvider {
    static var previews: some View {
        
    }
}

