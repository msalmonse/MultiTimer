//
//  ContentView.swift
//  MultiTimer WatchKit Extension
//
//  Created by Michael Salmon on 2019-08-26.
//  Copyright © 2019 mesme. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var timers = TimersList([
        SingleTimer(100).resume(),
        SingleTimer(10.9).resume(),
        SingleTimer(256.3).resume()
    ])

    var body: some View {
        MultiView()
        .environmentObject(timers)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
