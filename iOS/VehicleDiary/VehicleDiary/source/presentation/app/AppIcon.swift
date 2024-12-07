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
                .fill(.black)
                .ignoresSafeArea()
            ZStack {
                Rectangle()
                    .fill(
                        .linearGradient(
                            colors: [
                                SwiftUI.Color(.black).opacity(0.12),
                                SwiftUI.Color(.black).opacity(0.12)
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
                                .white.opacity(0.42)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
            }
            .frame(width: 1024, height: 1024)
        }

    }
}

#Preview("AppIcon") {
    AppIcon()
}
