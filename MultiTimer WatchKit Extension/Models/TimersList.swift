//
//  TimersList.swift
//  MultiTimer WatchKit Extension
//
//  Created by Michael Salmon on 2019-08-27.
//  Copyright © 2019 mesme. All rights reserved.
//

import Foundation

class TimersList: ObservableObject, Identifiable {
    let id = UUID()

    @Published
    var list: [SingleTimer]

    init(_ list: [SingleTimer] = []) {
        self.list = list
    }
}
