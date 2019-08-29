//
//  CachedTimer.swift
//  MultiTimer WatchKit Extension
//
//  Created by Michael Salmon on 2019-08-29.
//  Copyright © 2019 mesme. All rights reserved.
//

import Foundation

fileprivate let cacheTime: TimeInterval = 256

struct CachedTimer {
    let duration: TimeInterval
    let endDate: String

    let endCache: Date

    init(_ timer: SingleTimer) {
        self.duration = timer.duration
        self.endDate = timer.formattedEndDate
        endCache = Date(timeIntervalSinceNow: cacheTime)
    }
}
