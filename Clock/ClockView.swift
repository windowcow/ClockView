//
//  ClockView.swift
//  Clock
//
//  Created by windowcow on 3/16/24.
//

import SwiftUI
import Observation

extension AnyTransition {
    static func moveAndFade(edge: Edge) -> AnyTransition {
        let insertion = AnyTransition.scale.animation(.spring.delay(0.2))
        let removal = AnyTransition.opacity
        return .asymmetric(insertion: insertion, removal: removal)
    }
}
//let removal = AnyTransition.move(edge: edge).combined(with: .opacity)
struct FlipCardView: View {
    var text: String
    
    init(_ text: String) {
        self.text = text
    }
    var body: some View {
        if Int(text)!.isMultiple(of: 2) {
            let _ = print(1)
            Text(text)
                .font(.largeTitle)
                .bold()
                .monospacedDigit()
                .transition(.moveAndFade(edge: .top).animation(.spring))
        } else {
            Text(text)
                .font(.largeTitle)
                .bold()
                .monospacedDigit()
                .transition(.moveAndFade(edge: .top).animation(.spring))
        }
        
    }
}


struct ClockView: View {
    @State private var vm: ViewModel = ViewModel()
    
    var body: some View {
        VStack {
            TimelineView(.periodic(from: .now, by: vm.interval)) { context in
                HStack {
                    Group {
                        FlipCardView(vm.timeComponentsHolder.hour1)
                        FlipCardView(vm.timeComponentsHolder.hour2)
                        
                        Text(":")

                        FlipCardView(vm.timeComponentsHolder.minute1)
                        FlipCardView(vm.timeComponentsHolder.minute2)
                        
                        Text(":")

                        FlipCardView(vm.timeComponentsHolder.second1)
                        FlipCardView(vm.timeComponentsHolder.second2)

                    }
                    
                }
                .preference(key: CurrentTimePreferenceKey.self, value: context.date)
                
            }
            .onPreferenceChange(CurrentTimePreferenceKey.self) { date in
                vm.changeTime(date)
            }
            
            HStack {
                Button("START") {
                    vm.startTimer()
                }
                
                Button("PAUSE") {
                    vm.endTimer()
                }
            }
        }
        
    }
}

struct TimeSegment {
    let start: Date
    let end: Date
    var duration: TimeInterval {
        return end - start
    }
}



extension ClockView {
    @Observable final class ViewModel {
        var timeComponentsHolder = TimeComponentHolder()
        @ObservationIgnored var completedTimeSegments: [TimeSegment] = []
        
        var durationSumForCompletedTimeSegments: TimeInterval = 0
        
        var unfinishedStartTime: Date?
        
        
        var interval: TimeInterval {
            unfinishedStartTime == nil ? .greatestFiniteMagnitude : 1
        }
        
        func startTimer() {
            unfinishedStartTime = Date.now
        }
        
        func endTimer() {
            guard let unfinishedStartTime = unfinishedStartTime else { return }
            let end = Date.now
            let newTimeSegment = TimeSegment(start: unfinishedStartTime, end: end)
            
            completedTimeSegments.append(newTimeSegment)
            durationSumForCompletedTimeSegments += newTimeSegment.duration
            self.unfinishedStartTime = nil
        }
        
        func changeTime(_ currentTime: Date){
            if let unfinishedStartTime = unfinishedStartTime {
                timeComponentsHolder.wholeComponents = DateFormatterSingleton.shared.formattedTime(durationSumForCompletedTimeSegments + (currentTime - unfinishedStartTime))
            } else {
                timeComponentsHolder.wholeComponents = DateFormatterSingleton.shared.formattedTime(durationSumForCompletedTimeSegments)
            }
            
        }
    }
    @Observable final class TimeComponentHolder {
        var wholeComponents: (hour1: String, hour2: String, minute1: String, minute2: String, second1: String, second2: String) = ("0", "0", "0", "0", "0", "0") {
            didSet {
                if hour1 != wholeComponents.hour1 {
                    hour1 = wholeComponents.hour1
                }
                if hour2 != wholeComponents.hour2 {
                    hour2 = wholeComponents.hour2
                }
                if minute1 != wholeComponents.minute1 {
                    minute1 = wholeComponents.minute1
                }
                if minute2 != wholeComponents.minute2 {
                    minute2 = wholeComponents.minute2
                }
                if second1 != wholeComponents.second1 {
                    second1 = wholeComponents.second1
                }
                if second2 != wholeComponents.second2 {
                    second2 = wholeComponents.second2
                }
            }
        }
        
        var hour1: String = "0"
        var hour2: String = "0"

        var minute1: String = "0"
        var minute2: String = "0"

        var second1: String = "0"
        var second2: String = "0"
        
    }
}

extension Date {
    static func -(_ lhs: Date, _ rhs: Date) -> TimeInterval {
        lhs.timeIntervalSince(rhs)
    }
}

#Preview {
    ClockView()
}
