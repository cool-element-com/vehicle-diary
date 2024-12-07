//
//  Theme.swift
//  VehicleDiary
//
//  Created by boyan.yankov on 2024-11-25.
//

import SwiftUI

struct Theme {
    let completedEventConfig = Theme.Configuration.completedEventCard
    let pendingEventConfig = Theme.Configuration.pendingEventCard
    let defaultConfig = Theme.Configuration.default

    private init() {}

    static let `default` = Theme()
}

extension Theme {
    enum Color {
        static let dustyBlue = SwiftUI.Color(.dustyBlue)
        static let riverBlue = SwiftUI.Color(.riverBlue)
        static let naviBlue = SwiftUI.Color(.naviBlue)
        static let sandman = SwiftUI.Color(.sandman)
        static let orangejuice = SwiftUI.Color(.orangeJuice)
    }
}

extension Theme {
    struct Configuration {
        let backgroundColor: SwiftUI.Color
        let foregroundColor: SwiftUI.Color
        let textColor: SwiftUI.Color

        private init(
            backgroundColor: SwiftUI.Color,
            foregroundColor: SwiftUI.Color,
            textColor: SwiftUI.Color
        ) {
            self.backgroundColor = backgroundColor
            self.foregroundColor = foregroundColor
            self.textColor = textColor
        }

        static let completedEventCard: Theme.Configuration = .init(
            backgroundColor: Theme.Color.dustyBlue,
            foregroundColor: Theme.Color.riverBlue,
            textColor: Theme.Color.riverBlue
        )

        static let pendingEventCard: Theme.Configuration = .init(
            backgroundColor: Theme.Color.orangejuice,
            foregroundColor: Theme.Color.sandman,
            textColor: Theme.Color.sandman
        )

        static let `default`: Theme.Configuration = .init(
            backgroundColor: Theme.Color.dustyBlue,
            foregroundColor: Theme.Color.riverBlue,
            textColor: Theme.Color.riverBlue
        )
    }
}
