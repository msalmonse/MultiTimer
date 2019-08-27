//
//  Timer.swift
//  MultiTimer WatchKit Extension
//
//  Created by Michael Salmon on 2019-08-26.
//  Copyright © 2019 mesme. All rights reserved.
//

import SwiftUI
import Combine

enum TimerStatus {
    case active, inactive, ended, passive
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

    func rewind() {
        status = .inactive
        timeLeft = duration
        resume()
    }

    func pause() {
        status = .inactive
    }

    @discardableResult
    func resume() -> SingleTimer {
        if status == .inactive {
            endDate = Date() + timeLeft
            if tick == nil {
                tick = Timer.publish(
                    every: 0.25,
                    on: .main,
                    in: .default
                ).autoconnect().sink(receiveValue: {
                        [weak self] in self?.update($0)
                    }
                )
            }
            status = .active
        }
        return self
    }

    func end() {
        status = .ended
        timeLeft = 0
        tick = nil
    }

    func passivate() {
        status = .inactive
        timeLeft = duration
        tick = nil
    }

    init(_ duration: TimeInterval) {
        self.duration = duration
        self.timeLeft = duration
        self.endDate = Date() + duration
        self.status = .inactive
    }
}
