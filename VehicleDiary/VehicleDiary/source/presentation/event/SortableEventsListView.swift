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
    @State private var searchText = ""

    var searchResults: [VEvent] {
        if searchText.isEmpty {
            return events
        } else {
            return events.filter { event in
                event.name.localizedCaseInsensitiveContains(searchText)
                ||
                event.comment?.localizedCaseInsensitiveContains(searchText) ?? false
            }
        }
    }

    var body: some View {
        List {
            ForEach(searchResults) { event in
                EventRowView(event: event)
            }
            .onDelete(perform: { indexSet in
                deleteEvent(at: indexSet)
            })
        }
        .listStyle(.plain)
        .navigationTitle("\(vehicle.brand) \(vehicle.model)")
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $searchText)
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
        /// source https://fatbobman.com/en/posts/how-to-handle-optional-values-in-swiftdata-predicates/
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

    private func deleteEvent(at offsets: IndexSet) {
        for index in offsets {
            let event = searchResults[index]
            vehicle.events?.removeAll(where: { event1 in
                event.id == event1.id
            })
        }
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
