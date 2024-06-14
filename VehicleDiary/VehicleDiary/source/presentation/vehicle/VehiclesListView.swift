//
//  VehiclesListView.swift
//  VehicleDiary
//
//  Created by boyan.yankov on 2024-06-13.
//

import SwiftUI
import SwiftData

struct VehiclesListView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Vehicle.brand) var vehicles: [Vehicle]
    @State private var path = [Vehicle]()

    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(vehicles) { vehicle in
                    VehicleRowView(vehicle: vehicle)
                }
            }
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Vehicle.self, migrationPlan: .none, configurations: config)

        return VehiclesListView()
            .modelContainer(container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
