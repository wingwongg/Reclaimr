//
//  AddTaskPopupView.swift
//  Reclaimr
//
//  Created by ben on 12/5/25.
//

import SwiftUI

struct AddTaskPopupView: View {
    @Binding var isPresented: Bool
    var onConfirm: (String, Int) -> Void

    @State private var taskName: String = ""
    @State private var rewardTime: String = ""

    var body: some View {
        ZStack {
            Color.black.opacity(0.3)
                .ignoresSafeArea()

            VStack(spacing: 20) {
                Text("Add New Task")
                    .font(.headline)

                VStack(alignment: .leading, spacing: 12) {
                    Text("Task Name")
                        .font(.subheadline)
                    TextField("Enter task name", text: $taskName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    Text("Time Reward (in minutes)")
                        .font(.subheadline)
                    TextField("e.g. 15", text: $rewardTime)
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

struct AddTaskPopupView_Preview : PreviewProvider {
    static var previews: some View {
        
    }
}

