//
//  BottomDeleteConfirmationView.swift
//  Reclaimr
//
//  Created by ben on 13/5/25.
//

import SwiftUI

struct BottomDeleteConfirmationView: View {
    var onDelete: () -> Void
    var onCancel: () -> Void

    var body: some View {
        ZStack {
            // Transparent background but still detects taps
            Color.clear
                .contentShape(Rectangle()) // Ensures the tap area covers the full screen
                .onTapGesture {
                    onCancel()
                }

            // Bottom popup
            VStack {
                Spacer()
                VStack(spacing: 16) {
                    Button(action: {
                        onDelete()
                    }) {
                        Text("Delete")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(10)
                    }

                    Button(action: {
                        onCancel()
                    }) {
                        Text("Cancel")
                            .foregroundColor(.blue)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(.systemGray5))
                            .cornerRadius(10)
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(16)
                .shadow(radius: 10)
                .padding(.horizontal)
                .transition(.move(edge: .bottom).combined(with: .opacity))
                .animation(.easeInOut(duration: 10.0), value: true)
            }
        }
        .ignoresSafeArea()
    }
}
