//
//  CurrentDatePreferenceKey.swift
//  Clock
//
//  Created by windowcow on 3/17/24.
//

import SwiftUI

struct CurrentTimePreferenceKey: PreferenceKey {
    static var defaultValue: Date = Date()
    
    static func reduce(value: inout Date, nextValue: () -> Date) {
        value = nextValue()
    }
}
