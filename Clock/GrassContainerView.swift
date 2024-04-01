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
    var body: some View {
        VStack {
            Grid(horizontalSpacing: 5, verticalSpacing: 5) {
                ForEach(0 ..< 4) { n in
                    GridRow {
                        ForEach(start ..< end + 1) { _ in
                            Color.green
                                .opacity([0.4, 0.7, 1.0].randomElement()!)
                                .clipShape(.rect(cornerRadius: 3))
                                .aspectRatio(1.0, contentMode: .fit)
                        }
                    }
                    
                }
            }
            .padding()
            
            Spacer()
        }

    }
}

#Preview {
    GrassContainerView()
}
