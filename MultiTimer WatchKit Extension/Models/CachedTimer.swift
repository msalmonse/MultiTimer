//
//  CachedTimer.swift
//  MultiTimer WatchKit Extension
//
//  Created by Michael Salmon on 2019-08-29.
//  Copyright © 2019 mesme. All rights reserved.
//

import Foundation

fileprivate let cacheTime: TimeInterval = 256
fileprivate let cacheMax = 10

struct CachedTimer {
    private static var cache = [String: CachedTimer]()

    let duration: TimeInterval
    let endDate: String

    let endCache: Date

    static subscript(id: String) -> CachedTimer? {
        get { return cache[id] }
        set {
            cache[id] = newValue
            // Clean out old stuff
            let now = Date()
            for key in cache.keys where Self.cache[key]!.endCache < now {
                Self.cache.removeValue(forKey: key)
                if cache.count < cacheMax { break }
            }
        }
    }

    init(_ timer: SingleTimer) {
        self.duration = timer.duration
        self.endDate = timer.formattedEndDate
        endCache = Date(timeIntervalSinceNow: cacheTime)
    }
}
