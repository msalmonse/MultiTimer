//
//  AddTimer.swift
//  MultiTimer WatchKit Extension
//
//  Created by Michael Salmon on 2019-08-27.
//  Copyright © 2019 mesme. All rights reserved.
//

import SwiftUI

fileprivate let minDuration = 1.0
fileprivate let maxDuration = 60.0
fileprivate let colors: [Color] = [
    .red,
    .green,
    .blue,
    .yellow,
    Color(.cyan)
]

struct AddTimer: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @ObservedObject var timers: TimersList
    @State var duration: Double = minDuration

    func addTimer(_ color: Color) {
        timers.addTimer(duration * 60.0, color)
        dismiss()
    }

    func dismiss() {
        mode.wrappedValue.dismiss()
    }

    var body: some View {
        VStack {
            VStack(spacing: 1) {
                Slider(value: $duration, in: minDuration...maxDuration, step: 1.0)
                Text("\(duration)")
            }
            HStack {
                Text("Add with colour:")
                Spacer()
            }
            HStack {
                ForEach(colors.indices) {index in
                    Button(
                        action: { self.addTimer(colors[index]) },
                        label: {
                            Image(systemName: "star.fill").foregroundColor(colors[index])
                        }
                    )
                }
            }
        }
    }
}

struct AddTimer_Previews: PreviewProvider {
    @ObservedObject static var timers = TimersList()
    static var previews: some View {
        AddTimer(timers: timers)
    }
}
