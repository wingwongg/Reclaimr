//
//  ProductiveTaskModel.swift
//  Reclaimr
//
//  Created by ben on 9/5/25.
//

import SwiftUI

struct ProductiveTask {
    var description: String
    var timeRewarded: Int
    var pointsRewarded: Int
    var isCompleted: Bool
    
    var timeToCompelete: Int
    var startTime: Int
    var endTime: Int
}
