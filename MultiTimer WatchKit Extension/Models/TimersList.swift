//
//  TimersList.swift
//  MultiTimer WatchKit Extension
//
//  Created by Michael Salmon on 2019-08-27.
//  Copyright © 2019 mesme. All rights reserved.
//

import SwiftUI

class TimersList: ObservableObject, Identifiable {
    let id = UUID()

    @Published
    var list: [SingleTimer]

    func addTimer(_ duration: TimeInterval, _ color: Color = .clear) {
        list.append(SingleTimer(duration, color).resume())
    }

    func rmTimer(_ timer: SingleTimer) {
        for index in list.indices where timer.id == list[index].id {
            timer.passivate()
            list.remove(at: index)
            break
        }
    }

    init(_ list: [SingleTimer] = []) {
        self.list = list
    }
}
