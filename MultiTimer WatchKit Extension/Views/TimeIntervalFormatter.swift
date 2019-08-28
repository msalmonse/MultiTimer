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

func formattedTimeInterval(_ interval: TimeInterval, font: Font = .body) -> some View {

    // determine the correct image
    func namedImage(_ value: Int, _ divisor: Int = 1, zeroes: Bool = true) -> some View {
        let digit = (value/divisor)
        if !zeroes && digit == 0 { return Image(systemName: "square").opacity(0.2) }
        return Image(systemName: nameList[digit % 10]).opacity(1.0)
    }

    // calculate the colon padding
    func padding() -> CGFloat {
        switch font {
        case .largeTitle: return 8.0
        case .title: return 8.0
        default: return 5.0
        }
    }

    // calculate the colon width
    func width() -> CGFloat {
        switch font {
        case .largeTitle: return 16.0
        case .title: return 12.0
        default: return 8.0
        }
    }

    let seconds = Int(interval.truncatingRemainder(dividingBy: 60.0))
    let minutes = Int((interval/60.0).rounded(.down))
    return
        HStack(alignment: .center, spacing: 1) {
            namedImage(minutes, 100, zeroes: false)
            namedImage(minutes, 10, zeroes: false)
            namedImage(minutes)

            Text(":")
            .bold()
            .padding(.bottom, padding())
                .frame(width: width(), alignment: .center)

            namedImage(seconds, 10)
            namedImage(seconds)
        }.font(font)
}
