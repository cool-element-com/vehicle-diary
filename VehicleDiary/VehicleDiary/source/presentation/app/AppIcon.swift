//
//  AppIcon.swift
//  VehicleDiary
//
//  Created by boyan.yankov on 2024-06-19.
//

import SwiftUI

struct AppIcon: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(
                    .linearGradient(
                        colors: [
                            Color(red: 25/255, green: 215/255, blue: 255/255),
                            Color(red: 4/255, green: 8/255, blue: 255/255)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
            Image(systemName: "book.pages")
                .resizable()
                .scaledToFit()
                .padding(40)
                .foregroundStyle(
                    .linearGradient(
                        colors: [
                            .white,
                            .blue.opacity(0.2)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
        }
        .frame(width: 1024, height: 1024)

    }
}

#Preview("AppIcon") {
    AppIcon()
}
