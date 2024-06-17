//
//  SortableEventsListView.swift
//  VehicleDiary
//
//  Created by boyan.yankov on 2024-06-17.
//

import SwiftUI
import SwiftData

struct SortableEventsListView: View {
    @Bindable var vehicle: Vehicle
    @State private var isShowingCreateVehicleView = false
    @Query var events: [VEvent]

    var body: some View {
        List {
            ForEach(events) { event in
                EventRowView(event: event)
            }
        }
        .listStyle(.plain)
        .navigationTitle("\(vehicle.brand) \(vehicle.model)")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $isShowingCreateVehicleView, content: {
            CreateEventView(vehicle: vehicle)
        })
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Create event", systemImage: "plus") {
                    isShowingCreateVehicleView = true
                }
            }
        }
    }

    init(vehicle: Vehicle, sortOrder: [SortDescriptor<VEvent>]) {
        self.vehicle = vehicle
        let vehicleId = vehicle.id
        _events = Query(
            filter: #Predicate<VEvent> { event in
                if let eventVehicle = event.vehicle {
                    eventVehicle.id == vehicleId
                } else {
                    false
                }
            },
            sort: sortOrder)
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Vehicle.self, migrationPlan: .none, configurations: config)
        let vehicle = Vehicle(brand: "Subaru", model: "Outback", comment: "hello", millage: 12345, id: UUID().uuidString)
        container.mainContext.insert(vehicle)

        return NavigationStack {
            SortableEventsListView(
                vehicle: vehicle,
                sortOrder: [
                    SortDescriptor(\VEvent.nextDate)
                ]
            )
                    .modelContainer(container)
        }
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
