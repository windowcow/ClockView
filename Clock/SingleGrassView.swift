//
//  SingleGrassView.swift
//  Clock
//
//  Created by windowcow on 4/3/24.
//

import SwiftUI
import SwiftData

struct TaskType {
    var title: String
    var color: Color
}

struct TaskHistory {
    var startTime: DateComponents
    var endTime: DateComponents
    var taskType: TaskType
}

struct SingleGrassView: View {
//    @Query private var tasks: TaskHistory
    // from task history for the quarter, represent data
    var day: DateComponents
    var hour: Int
    var quarter: Int
    
    var body: some View {
        Color.green
            .opacity([0.4, 0.7, 1.0].randomElement()!)
            .clipShape(.rect(cornerRadius: 3))
            .aspectRatio(1.0, contentMode: .fit)
    }
}


