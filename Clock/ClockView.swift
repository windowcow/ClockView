//
//  ClockView.swift
//  Clock
//
//  Created by windowcow on 3/16/24.
//

import SwiftUI
import Observation

struct FlipCardPageViewModifier: ViewModifier {
    var font: Font
    
    func body(content: Content) -> some View {
        content
            .monospacedDigit()
            .foregroundStyle(.white)
            .font(font)
            .bold()
            .padding()
            .background(.black, in: .rect(cornerRadius: 10))
    }
}



struct FlipCardView: View {
    var text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    var body: some View {
        Text(text)
            .id(text)
            .modifier(FlipCardPageViewModifier(font: .title))

            .transition(
                .asymmetric(
                    insertion: .push(from: .top).animation(.spring(duration: 0.3).delay(0.2)),
                    removal: AnyTransition(FlipCardTransition().animation(.easeIn(duration: 0.75))))
            )
    }
}

struct FlipPagesContainerSize: PreferenceKey {
    static var defaultValue: CGSize = .zero
    
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}


struct ClockView: View {
    @State private var vm: ViewModel = ViewModel()
    @State private var flipPagesContainerSize: CGSize = .zero
    
    var body: some View {
        VStack {
            Spacer()
            
            TimelineView(.periodic(from: .now, by: vm.interval)) { context in
                HStack {
                    FlipCardView(vm.timeComponentsHolder.hour1)
                    FlipCardView(vm.timeComponentsHolder.hour2)
                    
                    Spacer()
                    
                    FlipCardView(vm.timeComponentsHolder.minute1)
                    FlipCardView(vm.timeComponentsHolder.minute2)
                    
                    Spacer()

                    FlipCardView(vm.timeComponentsHolder.second1)
                    FlipCardView(vm.timeComponentsHolder.second2)
                }
                .padding(.horizontal)
                .overlay {
                    GeometryReader { geo in
                        Color.clear
                            .preference(key: FlipPagesContainerSize.self, value: geo.size)
                    }
                    .onPreferenceChange(FlipPagesContainerSize.self) { size in
                        flipPagesContainerSize = size
                    }
                    
                }
                .preference(key: CurrentTimePreferenceKey.self, value: context.date)
                
            }
            .onPreferenceChange(CurrentTimePreferenceKey.self) { date in
                vm.changeTime(date)
            }
            
            Spacer()
            
            HStack {
                Spacer()

                Button {
                    vm.endTimer()
                } label: {
                    Image(systemName: "stop")
                        .font(.title)
                        .padding()
                        .frame(width: flipPagesContainerSize.height, height: flipPagesContainerSize.height)

                        .background(.red, in: .circle)
                        .foregroundStyle(.white)
                        .bold()
                        
                }
                
                Spacer()
                
                Button {
                    if !vm.isTimerRunning {
                        vm.startTimer()
                    } else {
                        vm.endTimer()
                    }
                } label: {
                    Image(systemName: vm.isTimerRunning ? "pause" : "play" )
                        .font(.title)
                        .padding()
                        .frame(width: flipPagesContainerSize.height, height: flipPagesContainerSize.height)

                        .background(vm.isTimerRunning ? .gray : .green, in: .circle)
                        .foregroundStyle(.white)
                        .bold()
                }
                Spacer()

            }
        }
        
    }
}


#Preview {
    ClockView()
}
