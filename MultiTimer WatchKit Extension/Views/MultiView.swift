//
//  MultiView.swift
//  MultiTimer WatchKit Extension
//
//  Created by Michael Salmon on 2019-08-26.
//  Copyright © 2019 mesme. All rights reserved.
//

import SwiftUI

fileprivate func blinkOn(_ now: Double) -> Bool {
    let blinkRate = 1.6
    return now.truncatingRemainder(dividingBy: blinkRate)/blinkRate > 0.5
}

struct MultiView: View {
    @State var timerList: TimerList = [
        SingleTimer(100).resume(),
        SingleTimer(10).resume(),
        SingleTimer(256.3).resume()
    ]
    @State var colorToggle: Bool = false

    var body: some View {
        VStack(spacing: 1) {
            ForEach(timerList) { timer in
                SingleView(timer: timer, toggle: self.$colorToggle)
            }
        }
        .onReceive(
            timerPublisher.autoconnect(),
            perform: { self.colorToggle = blinkOn($0.timeIntervalSince1970) }
        )
    }
}

struct SingleView: View {
    @ObservedObject var timer: SingleTimer
    @Binding var toggle: Bool

    func nowColor() -> Color {
        switch timer.status {
        case .active: return .primary
        case .inactive: return .secondary
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
