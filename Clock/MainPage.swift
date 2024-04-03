//
//  MainPage.swift
//  Clock
//
//  Created by windowcow on 4/3/24.
//

import SwiftUI

extension Date {
    var ymd: DateComponents {
        Calendar.autoupdatingCurrent.dateComponents([.year, .month, .day], from: self)
    }
}

struct MainPage: View {
    @State private var today: Date = .now
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    DatePicker(selection: $today, displayedComponents: [.date]) {
                    }
                    .fixedSize()
                    
                    HStack {
                        Text("DDay")
                        Text("DDay")
                        Text("DDay")
                    }
                    
                    Spacer()
                }
                
                GrassContainerView(today: today.ymd)
                GroupBox {
                    Text("막대그래프")
                }
            }
            .padding()
            
            Color.gray
                .frame(maxWidth: 300)
                .overlay {
                    Button("START") {
                        
                    }
                    .buttonStyle(.bordered)
                    .tint(.white)
                }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    MainPage()
}
