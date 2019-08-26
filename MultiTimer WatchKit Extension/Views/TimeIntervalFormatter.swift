//
//  TimeIntervalFormatter.swift
//  MultiTimer WatchKit Extension
//
//  Created by Michael Salmon on 2019-08-26.
//  Copyright © 2019 mesme. All rights reserved.
//

import SwiftUI

fileprivate let nameList = [
    "0.square",
    "1.square",
    "2.square",
    "3.square",
    "4.square",
    "5.square",
    "6.alt.square",
    "7.square",
    "8.square",
    "9.alt.square"
]

func formattedTimeInterval(_ interval: TimeInterval) -> some View {

    // determine the correct image
    func namedImage(_ value: Int, _ divisor: Int = 1, zeroes: Bool = true) -> some View {
        let result = (value/divisor)
        let name = !zeroes && result == 0 ? "square" : nameList[result % 10]
        return Image(systemName: name)
    }

    let seconds = Int(interval.truncatingRemainder(dividingBy: 60.0))
    let minutes = Int((interval/60.0).rounded(.down))
    return
        HStack(spacing: 1) {
            namedImage(minutes, 100, zeroes: false)
            namedImage(minutes, 10, zeroes: false)
            namedImage(minutes)
            Text(":")
            namedImage(seconds, 10)
            namedImage(seconds)
        }
}
