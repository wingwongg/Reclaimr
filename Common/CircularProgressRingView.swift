//
//  CircularProgressRingView.swift
//  Reclaimr
//
//  Created by ben on 9/5/25.
//

import SwiftUI

struct CircularProgressRing: View {
    var progress: Double // 0.0 to 1.0
    var thickness: CGFloat = 10
    var size: CGFloat = 100
    var color: Color = .green
    var backgroundColor: Color = .gray.opacity(0.2)

    var body: some View {
        ZStack {
            // Background ring
            Circle()
                .stroke(backgroundColor, lineWidth: thickness)

            // Progress ring
            Circle()
                .trim(from: 0.0, to: progress)
                .stroke(color,
                        style: StrokeStyle(lineWidth: thickness, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut(duration: 0.5), value: progress)

            // Optional center content
            Text("\(Int(progress * 100))%")
                .font(.caption)
                .bold()
        }
        .frame(width: size, height: size)
    }
}

