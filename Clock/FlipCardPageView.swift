//
//  FlipCardPageView.swift
//  Clock
//
//  Created by windowcow on 3/20/24.
//

import SwiftUI
struct FlipCardTransition: Transition {
    func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .rotation3DEffect(
                .degrees(phase.rotation),
                axis: (x: 1.0, y: 0.0, z: 0.0 ),
                anchor: .top,
                anchorZ: -10,
                perspective: 0.45
            )
    }
}

extension TransitionPhase {
    fileprivate var rotation: CGFloat {
        switch self {
        case .willAppear: return 0
        case .identity: return 0
        case .didDisappear: return 360
        }
    }
    
    fileprivate var animation: Animation {
        switch self {
        case .willAppear: return .easeIn(duration: 0.25)
        case .identity: return .default
        case .didDisappear: return .easeIn(duration: 0.75)
        }
    }
}


struct FlipCardPageView: View {
    var body: some View {
        Text("0")
            .foregroundStyle(.white)
            .font(.largeTitle)
            .bold()
            .padding()
            .background {
                Color.black
            }
    }
}

struct FlipCardPractive: View {
    @State private var f = false
    var body: some View {
        VStack {
            if f {
                FlipCardPageView()
                    
            }
            
                
            Button("TAP") {
                f.toggle()
            }
        }
    }
}

#Preview {
    FlipCardPractive()
}
