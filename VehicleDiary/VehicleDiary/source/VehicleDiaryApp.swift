//
//  VehicleDiaryApp.swift
//  VehicleDiary
//
//  Created by boyan.yankov on 2024-06-13.
//

import SwiftUI
import SwiftData

@main
struct VehicleDiaryApp: App {
    var body: some Scene {
        WindowGroup {
            AppTabView()
                .modelContainer(for: Vehicle.self)
        }
    }
}
