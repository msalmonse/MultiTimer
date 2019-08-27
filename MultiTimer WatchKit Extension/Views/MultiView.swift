//
//  MultiView.swift
//  MultiTimer WatchKit Extension
//
//  Created by Michael Salmon on 2019-08-26.
//  Copyright © 2019 mesme. All rights reserved.
//

import SwiftUI

fileprivate let blinkRate = 1.6     // period between blinks

fileprivate func blinkOn(_ now: Double) -> Bool {
    return now.truncatingRemainder(dividingBy: blinkRate)/blinkRate > 0.5
}

struct MultiView: View {
    @State var colorToggle: Bool = false
    @EnvironmentObject var timers: TimersList

    var body: some View {
        VStack(spacing: 1) {
            List(timers.list) { timer in
                Spacer()
                NavigationLink(
                    destination: DetailView(timer: timer).environmentObject(self.timers),
                    label: { SingleView(timer: timer, toggle: self.$colorToggle) }
                )
                Spacer()
            }
            .listStyle(CarouselListStyle())
            .onReceive(
                Timer.publish(every: blinkRate/4.0, on: .main, in: .default).autoconnect(),
                perform: { self.colorToggle = blinkOn($0.timeIntervalSince1970) }
            )

            NavigationLink(
                destination: AddTimer().environmentObject(timers),
                label: { Text("Add Timer").font(.caption) }
            )
        }
    }
}

struct SingleView: View {
    @ObservedObject var timer: SingleTimer
    @Binding var toggle: Bool

    func nowColor() -> Color {
        switch timer.status {
        case .active: return .primary
        case .inactive, .passive: return .secondary
        case .ended: return toggle ? .red : .secondary
        }
    }

    var body: some View {
        formattedTimeInterval(timer.timeLeft)
        .foregroundColor(nowColor())
    }
}

struct MultiView_Previews: PreviewProvider {
    static var previews: some View {
        MultiView()
    }
}
