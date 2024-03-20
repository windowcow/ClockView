//
//  FlipCardPageView.swift
//  Clock
//
//  Created by windowcow on 3/20/24.
//

import SwiftUI
//
//struct FlipCardViewModifier: ViewModifier {
//    var rotateAngle: CGFloat
//    
//    func body(content: Content) -> some View {
//        content
//            .foregroundStyle(rotateAngle <= 90 ? .white : .black)
//            .rotation3DEffect(
//                .degrees(rotateAngle),
//                axis: (x: -1.0, y: 0.0, z: 0.0 ),
//                anchor: .top,
//                perspective: 0.4
//            )
//    }
//}
//
//extension ViewModifier {
//    static func flipCard(_ rotateAngle: CGFloat) -> some ViewModifier {
//        FlipCardViewModifier(rotateAngle: rotateAngle)
//    }
//}

struct FlipCardTransition: Transition {
    func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .foregroundStyle(phase.rotation <= 90 ? .white : .black)
            .rotation3DEffect(
                .degrees(phase.rotation),
                axis: (x: 1.0, y: 0.0, z: 0.0 ),
                anchor: .top,
                perspective: 0.45
            )
            .animation(phase.animation, value: phase)

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
        case .identity: return .default
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
    var body: some View {
        Text("0")
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
                    .transition(FlipCardTransition())
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
