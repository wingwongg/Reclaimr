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
        VStack() {
            Text("You have \(formatMinutesToHourMinute(120.0 - convertToMinutes(from: totalActivity))) of screen time remaining")
                .padding(.vertical, 40)
                .padding(.horizontal, 20)
            
            HStack() {
                // customize activity report
                CircularProgressRing(progress: Double(convertToMinutes(from: totalActivity)) / 120.0, size: 150, color: .blue)
                    .padding(.leading, 30.0)
                
                // Circle productive hours
                CircularProgressRing(progress: 0.4, size: 150, color: .green)
                    .padding(.trailing, 30.0)
                    .frame(width: 200.0, height: 200.0)
            }
        }
    }
}

func convertToMinutes(from timeString: String) -> Double {
    var totalMinutes: Double = 0.0
    
    let pattern = #"(?:(\d+)h)?\s*(?:(\d+)m)?"#
    let regex = try! NSRegularExpression(pattern: pattern, options: [])
    
    if let match = regex.firstMatch(in: timeString, options: [], range: NSRange(location: 0, length: timeString.utf16.count)) {
        if let hourRange = Range(match.range(at: 1), in: timeString),
           let hours = Double(timeString[hourRange]) {
            totalMinutes += hours * 60
        }
        if let minuteRange = Range(match.range(at: 2), in: timeString),
           let minutes = Double(timeString[minuteRange]) {
            totalMinutes += minutes
        }
    }
    
    return totalMinutes
}

func formatMinutesToHourMinute(_ totalMinutes: Double) -> String {
    let totalWholeMinutes = Int(totalMinutes)
    let hours = totalWholeMinutes / 60
    let minutes = totalWholeMinutes % 60

    let formattedHours = hours < 10 ? "\(hours)h" : String(format: "%02dh", hours)
    let formattedMinutes = String(format: "%02dm", minutes)

    return formattedHours + formattedMinutes
}



// In order to support previews for your extension's custom views, make sure its source files are
// members of your app's Xcode target as well as members of your extension's target. You can use
// Xcode's File Inspector to modify a file's Target Membership.
#Preview {
    TotalActivityView(totalActivity: "1h 23m")
}
