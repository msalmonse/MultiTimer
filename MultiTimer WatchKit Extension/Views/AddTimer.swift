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

struct AddTimer: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @EnvironmentObject var timers: TimersList
    @State var duration: Double = minDuration

    func dismiss() {
        mode.wrappedValue.dismiss()
    }

    var body: some View {
        VStack {
            VStack(spacing: 1) {
                Slider(value: $duration, in: minDuration...maxDuration, step: 1.0)
                Text("\(duration)")
            }
            Button(
                action: { self.timers.addTimer(self.duration * 60.0); self.dismiss() },
                label: { Text("Add").foregroundColor(.primary) }
            )
        }
    }
}

struct AddTimer_Previews: PreviewProvider {
    static var previews: some View {
        AddTimer()
    }
}
