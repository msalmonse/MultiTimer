//
//  DetailView.swift
//  MultiTimer WatchKit Extension
//
//  Created by Michael Salmon on 2019-08-27.
//  Copyright © 2019 mesme. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var timer: SingleTimer

    var body: some View {
        VStack {
            formattedTimeInterval(timer.timeLeft)
            .font(.largeTitle)
            HStack {
                Button(
                    action: { self.timer.rewind() },
                    label: { Image(systemName: "backward.end.fill") }
                )
                Button(
                    action: { self.timer.pause() },
                    label: { Image(systemName: "pause.fill") }
                )
                Button(
                    action: { self.timer.resume() },
                    label: { Image(systemName: "play.fill") }
                )
                Button(
                    action: { self.timer.passivate() },
                    label: { Image(systemName: "stop.fill") }
                )
                Button(
                    action: { self.timer.end() },
                    label: { Image(systemName: "forward.end.fill") }
                )
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    @ObservedObject static var timer = SingleTimer(10)

    static var previews: some View {
        DetailView(timer: timer)
    }
}
