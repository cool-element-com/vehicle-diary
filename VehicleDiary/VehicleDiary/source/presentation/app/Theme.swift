//
//  Theme.swift
//  VehicleDiary
//
//  Created by boyan.yankov on 2024-11-25.
//

import SwiftUI

struct Theme {
    let colors: [SwiftUI.Color] = Theme.Color.all
    let completedEventConfig = Theme.Configuration.completedEventCard
    let pendingEventConfig = Theme.Configuration.pendingEventCard

    private init() {}

    static let `default` = Theme()
}

extension Theme {
    enum Color {
        static let color_0 = SwiftUI.Color(hex: "#8ECAE6")
        static let color_1 = SwiftUI.Color(hex: "#219EBC")
        static let color_2 = SwiftUI.Color(hex: "#023047")
        static let color_3 = SwiftUI.Color(hex: "#FFB703")
        static let color_4 = SwiftUI.Color(hex: "#FB8500")

        static let all: [SwiftUI.Color] = [
            color_0,
            color_1,
            color_2,
            color_3,
            color_4
        ]
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
            backgroundColor: Theme.Color.color_0,
            foregroundColor: Theme.Color.color_1,
            textColor: Theme.Color.color_2
        )

        static let pendingEventCard: Theme.Configuration = .init(
            backgroundColor: Theme.Color.color_3,
            foregroundColor: Theme.Color.color_4,
            textColor: Theme.Color.color_2
        )
    }
}
