//
//  TextPractice.swift
//  Clock
//
//  Created by windowcow on 3/20/24.
//

import SwiftUI


struct TextPractice: View {
    @State private var toggle = false
    
    var body: some View {
        VStack {
            Text("hi")
                .bold()
                .font(.largeTitle)
                .padding()
                .foregroundStyle(toggle ? .blue : .black)

                .animation(.spring(duration: 3), value: toggle)
            
            Button("TAP") {
                toggle.toggle()
            }
        }
        
    }
}

#Preview {
    TextPractice()
}
