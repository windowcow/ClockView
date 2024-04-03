//
//  GrassContainerView.swift
//  Clock
//
//  Created by windowcow on 3/28/24.
//

import SwiftUI

enum Segment: CaseIterable {
    case zero, one, two, three, four, five, six, seven, eight, nine, ten, eleven
    
    func range() -> Range<Int> {
        switch self {
        case .zero:
            return 0..<5
        case .one:
            return 5..<10
        case .two:
            return 10..<15
        case .three:
            return 15..<20
        case .four:
            return 20..<25
        case .five:
            return 25..<30
        case .six:
            return 30..<35
        case .seven:
            return 35..<40
        case .eight:
            return 40..<45
        case .nine:
            return 45..<50
        case .ten:
            return 50..<55
        case .eleven:
            return 55..<60
        }
    }
    
    static func segment(for value: Int) -> Segment? {
        for segment in Segment.allCases {
            if segment.range().contains(value) {
                return segment
            }
        }
        return nil
    }
}

let start = 0
let end = 24

struct GrassContainerView: View {
    var today: DateComponents // which has Calendaer, year, month, day
    
    var body: some View {
        HStack(alignment: .top) {
            ForEach(start ..< end ) { hour in
                GrassContainerColumn(day: today, hour: hour)
            }
        }
        
    }
}

struct GrassContainerColumn: View {
    var day: DateComponents
    var hour: Int
    
    var body: some View {
        LazyVStack(spacing: 5) {
            Text(hour.description)
                .font(.caption)
                .fixedSize()
            
            ForEach(0 ..< 4 ) { quarter in
                SingleGrassView(day: day, hour: hour, quarter: quarter)
            }
        }
    }
}



#Preview {
    GrassContainerView(today: Calendar.autoupdatingCurrent.dateComponents([.year, .month, .day], from: Date.now))
}
