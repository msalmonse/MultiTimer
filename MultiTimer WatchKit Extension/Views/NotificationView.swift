//
//  NotificationView.swift
//  MultiTimer WatchKit Extension
//
//  Created by Michael Salmon on 2019-08-26.
//  Copyright © 2019 mesme. All rights reserved.
//

import SwiftUI

struct NotificationView: View {
    let timer: CachedTimer?
    let expired: String

    init(id: String) {
        timer = CachedTimer[id]
        expired = timer == nil ? "" : timer!.endDate
    }

    var body: some View {
        VStack {
            if timer == nil {
                Text("Timer expired")
            } else {
                Text("Timer expired at:")
                Text(expired)
            }
        }
    }
}

#if DEBUG
struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView(id: "")
    }
}
#endif
