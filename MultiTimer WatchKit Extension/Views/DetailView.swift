//
//  DetailView.swift
//  MultiTimer WatchKit Extension
//
//  Created by Michael Salmon on 2019-08-27.
//  Copyright © 2019 mesme. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @EnvironmentObject var timers: TimersList
    @ObservedObject var timer: SingleTimer

    func dismiss() {
        mode.wrappedValue.dismiss()
    }

    var body: some View {
        VStack {
            formattedTimeInterval(timer.timeLeft)
            .font(.largeTitle)
            HStack {
                Button(
                    action: { self.timer.rewind() },
                    label: { Image(systemName: "backward.end.fill") }
                )
                Button(
                    action: { self.timer.pause() },
                    label: { Image(systemName: "pause.fill") }
                )
                Button(
                    action: { self.timer.resume() },
                    label: { Image(systemName: "play.fill") }
                )
                Button(
                    action: { self.timer.passivate() },
                    label: { Image(systemName: "stop.fill") }
                )
                Button(
                    action: { self.timer.end() },
                    label: { Image(systemName: "forward.end.fill") }
                )
                Spacer()
                Button(
                    action: { self.timers.rmTimer(self.timer); self.dismiss() },
                    label: { Image(systemName: "clear").foregroundColor(.red) }
                )
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    @ObservedObject static var timer = SingleTimer(10)

    static var previews: some View {
        DetailView(timer: timer)
    }
}
