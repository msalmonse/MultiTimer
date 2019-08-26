//
//  Timer.swift
//  MultiTimer WatchKit Extension
//
//  Created by Michael Salmon on 2019-08-26.
//  Copyright © 2019 mesme. All rights reserved.
//

import SwiftUI
import Combine

let timerPublisher = Timer.publish(every: 0.25, on: .main, in: .default)

enum TimerStatus {
    case active, inactive, ended
}

class SingleTimer: ObservableObject, Identifiable {
    var id = UUID()

    @Published
    var status: TimerStatus = .inactive

    @Published
    var timeLeft: TimeInterval

    let duration: TimeInterval
    var endDate: Date

    var tick: AnyCancellable? = nil

    private func update(_ now: Date) {
        if status == .active {
            if endDate > now {
                timeLeft = now.distance(to: endDate)
            } else {
                end()
            }
        }
    }

    func pause() {
        status = .inactive
        tick?.cancel()
    }

    func resume() -> SingleTimer {
        if status == .inactive {
            endDate = Date() + timeLeft
            tick = timerPublisher.autoconnect().sink(receiveValue: { [weak self] in self?.update($0) })
            status = .active
        }
        return self
    }

    func end() {
        status = .ended
        timeLeft = 0
    }

    init(_ duration: TimeInterval) {
        self.duration = duration
        self.timeLeft = duration
        self.endDate = Date() + duration
        self.status = .inactive
    }
}

typealias TimerList = [SingleTimer]
