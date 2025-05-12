//
//  TotalActivityView.swift
//  ReclaimrReportExtension
//
//  Created by ben on 9/5/25.
//

import SwiftUI

struct TotalActivityView: View {
    let totalActivity: String
    
    var body: some View {
//        CircularProgressRing(progress: Double(convertToMinutes(from: totalActivity)) / 120.0, size: 150, color: .blue)
//            .padding(.leading, 30.0)
        CircularProgressRing(progress: 100.0 / 120.0, size: 150, color: .blue)
            .padding(.leading, 30.0)
    }
}

func convertToMinutes(from timeString: String) -> Int {
    var totalMinutes = 0
    
    let pattern = #"(?:(\d+)h)?\s*(?:(\d+)m)?"#
    let regex = try! NSRegularExpression(pattern: pattern, options: [])
    
    if let match = regex.firstMatch(in: timeString, options: [], range: NSRange(location: 0, length: timeString.utf16.count)) {
        if let hourRange = Range(match.range(at: 1), in: timeString),
           let hours = Int(timeString[hourRange]) {
            totalMinutes += hours * 60
        }
        if let minuteRange = Range(match.range(at: 2), in: timeString),
           let minutes = Int(timeString[minuteRange]) {
            totalMinutes += minutes
        }
    }
    
    return totalMinutes
}

// In order to support previews for your extension's custom views, make sure its source files are
// members of your app's Xcode target as well as members of your extension's target. You can use
// Xcode's File Inspector to modify a file's Target Membership.
#Preview {
    TotalActivityView(totalActivity: "1h 23m")
}
