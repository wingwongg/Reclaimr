//
//  TotalActivityView.swift
//  ReclaimrReportExtension
//
//  Created by ben on 9/5/25.
//

import SwiftUI

struct TotalActivityView: View {
    let totalActivity: String
    let screenTimeLimit = UserDefaults(suiteName: "group.com.nebitrams.Reclaimr")!.integer(forKey: "dailyScreenTimeLimit")
    let productivityGoal = UserDefaults(suiteName: "group.com.nebitrams.Reclaimr")!.integer(forKey: "dailyProductiveGoal")

    var body: some View {
        let timeLeft = Double(screenTimeLimit) * 60.0 - convertToMinutes(from: totalActivity)
        
        VStack() {
            Text("You have \(formatMinutesToHourMinute(timeLeft)) of screentime left")
                .padding(.vertical, 40)
                .padding(.horizontal, 20)
            
            HStack() {
                // screen time progress
                CircularProgressRing(progress: Double(convertToMinutes(from: totalActivity)) / (Double(screenTimeLimit) * 60.0), thickness: 13, size: 130, color: .blue)
                    .padding(.leading, 30)
                    .padding(.trailing, 10)
                
                // productive progress
                CircularProgressRing(progress: Double(5) / (Double(productivityGoal) * 60.0), thickness: 13, size: 130)
                    .padding(.trailing, 30)
                    .padding(.leading, 10)
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
