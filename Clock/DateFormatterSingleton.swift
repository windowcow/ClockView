//
//  DataFormatterSingleton.swift
//  Clock
//
//  Created by windowcow on 3/17/24.
//

import Foundation

class DateFormatterSingleton {
    static let shared = DateFormatterSingleton()

    let formatter: DateComponentsFormatter

    private init() {
        formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        formatter.allowedUnits = [.hour, .minute, .second]
    }
    
    func formattedTime(_ duration: TimeInterval) -> (hour1: String, hour2: String, minute1: String, minute2: String, second1: String, second2: String) {
        let wholeString: String = formatter.string(from: duration)!

        
        // 시간, 분, 초 각각의 십의 자리와 일의 자리를 분리하여 반환
        let hour1 = String(wholeString[wholeString.startIndex])
        let hour2 = String(wholeString[wholeString.index(wholeString.startIndex, offsetBy: 1)])
        let minute1 = String(wholeString[wholeString.index(wholeString.startIndex, offsetBy: 3)])
        let minute2 = String(wholeString[wholeString.index(wholeString.startIndex, offsetBy: 4)])
        let second1 = String(wholeString[wholeString.index(wholeString.startIndex, offsetBy: 6)])
        let second2 = String(wholeString[wholeString.index(wholeString.startIndex, offsetBy: 7)])

        return (hour1, hour2, minute1, minute2, second1, second2)
    }
}
