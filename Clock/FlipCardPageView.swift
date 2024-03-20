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
            .visualEffect { content, geometryProxy in
                content
                    .layerEffect(ShaderLibrary.makeBlack(), maxSampleOffset: .zero, isEnabled: phase.rotation >= 180 ? true : false )
                    .rotation3DEffect(
                        .degrees(phase.rotation),
                        axis: (x: 1.0, y: 0.0, z: 0.0 ),
                        anchor: .top,
                        perspective: 0.45
                    )

            }
            .animation(.spring(duration: 3), value: phase)
    }
}

extension TransitionPhase {
    fileprivate var rotation: CGFloat {
        switch self {
        case .willAppear: return -30
        case .identity: return 0
        case .didDisappear: return 360
        }
    }
    
    fileprivate var animation: Animation {
        switch self {
        case .willAppear: return .easeIn(duration: 0.25)
        case .identity: return .easeInOut(duration: 2.0)
        case .didDisappear: return .easeInOut(duration: 2.0)
        }
    }
    
    fileprivate var foregroundOpacity: CGFloat {
        switch self {
        case .willAppear: return 1.0
        case .identity: return 1.0
        case .didDisappear: return 0.0
        }
    }
}


struct FlipCardPageView: View {
//    var textForegroundColor: Color
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
                    .transition(FlipCardTransition().animation(.spring(duration: 3)))
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
