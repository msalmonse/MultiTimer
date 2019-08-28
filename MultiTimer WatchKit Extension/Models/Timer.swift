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
    case active, inactive, ended, notifying
}

class SingleTimer: ObservableObject, Identifiable {
    var id = UUID()

    @Published
    var status: TimerStatus = .inactive

    @Published
    var timeLeft: TimeInterval

    let duration: TimeInterval
    var endDate: Date

    let color: Color

    var tick: AnyCancellable? = nil

    private func update(_ now: Date) {
        if status == .active {
            if endDate > now {
                timeLeft = now.distance(to: endDate)
            } else {
                notify()
            }
        }
    }

    func notify() {
        if status == .active {
            status = .notifying
            sendNotification(for: self)
            end()
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

    init(_ duration: TimeInterval, _ color: Color = .clear) {
        // random double between 0 and 1
        func rand() -> Double {
            return Double.random(in: 0.0...1.0)
        }

        self.duration = duration
        self.timeLeft = duration
        self.endDate = Date() + duration
        self.status = .inactive
        if color != .clear {
            self.color = color
        } else {
            self.color = Color(red: rand(), green: rand(), blue: rand(), opacity: 1.0)
        }
    }

    deinit {
        tick?.cancel()
    }
}
