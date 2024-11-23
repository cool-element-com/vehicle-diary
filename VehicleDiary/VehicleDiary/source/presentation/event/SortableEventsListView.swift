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
    @State private var editEvent: VEvent?

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

    private func backgroundColor(for event: VEvent) -> Color {
        if event.isCompleted {
            return .green
        } else {
            return .red
        }
    }

    var body: some View {
        List {
            ForEach(searchResults) { event in
                NavigationLink(value: event) {
                    EventRowView(event: event)
                }
                .swipeActions(edge: .leading, allowsFullSwipe: true) {
                    Button {
                        editEvent = event
                    } label: {
                        Label("Edit", systemImage: "square.and.pencil")
                    }
                    .tint(.green)
                }
                .padding(8)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(backgroundColor(for: event))
                )
            }
            .onDelete(perform: { indexSet in
                deleteEvent(at: indexSet)
            })
        }
        .navigationDestination(for: VEvent.self) { event in
            EventView(event: event)
                .dynamicTypeSize(...DynamicTypeSize.large)
        }
        .listStyle(.plain)
        .navigationTitle("\(vehicle.brand) \(vehicle.model)")
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $searchText)
        .sheet(isPresented: $isShowingCreateVehicleView, content: {
            CreateEventView(vehicle: vehicle)
        })
        .sheet(item: $editEvent, content: { event in
            EditEventView(event: event)
        })
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Create event", systemImage: "plus") {
                    isShowingCreateVehicleView = true
                }
            }
        }
    }

    init(
        vehicle: Vehicle,
        sortOrder: [SortDescriptor<VEvent>],
        visibility: EventsListView.Visibility
    ) {
        self.vehicle = vehicle
        let vehicleId = vehicle.id
        /// source https://fatbobman.com/en/posts/how-to-handle-optional-values-in-swiftdata-predicates/
        switch visibility {
        case .showAll:
            _events = Query(
                filter: #Predicate<VEvent> { event in
                    if let eventVehicle = event.vehicle {
                        eventVehicle.id == vehicleId
                    } else {
                        false
                    }
                },
                sort: sortOrder)
        case .showCompleted:
            _events = Query(
                filter: #Predicate<VEvent> { event in
                    if let eventVehicle = event.vehicle {
                        eventVehicle.id == vehicleId
                        &&
                        event.isCompleted == true
                    } else {
                        false
                    }
                },
                sort: sortOrder)
        case .showNotCompleted:
            _events = Query(
                filter: #Predicate<VEvent> { event in
                    if let eventVehicle = event.vehicle {
                        eventVehicle.id == vehicleId
                        &&
                        event.isCompleted == false
                    } else {
                        false
                    }
                },
                sort: sortOrder)
        }
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
        let vehicle = Vehicle(brand: "Subaru", model: "Outback", comment: "hello", mileage: 12345, id: UUID().uuidString)
        container.mainContext.insert(vehicle)

        var events = [VEvent]()
        for number in 0..<20 {
            let numberDouble = Double(number)
            let event = VEvent(
                name: "Event \(number)",
                comment: number.isMultiple(of: 2) ? """
this is a comment for a long event
new line is also very important
as third line as well
""" : nil,
                recordedDate: Date.init(timeIntervalSinceNow: Double.random(in: 10_000...1_000_000_000) + 100 * numberDouble),
                upcomingDate: Date(timeIntervalSinceNow: Double.random(in: 10_000...1_000_000_000) + 1_000 * numberDouble),
                recordedMileage: Double.random(in: 1_000...10_000) + 1_203 * numberDouble,
                upcomingMileage: Double.random(in: 10_000...10_500) + 1_230 * numberDouble,
                isCompleted: number.isMultiple(of: 2)
            )
            events.append(event)
        }
        vehicle.events = events

        return NavigationStack {
            SortableEventsListView(
                vehicle: vehicle,
                sortOrder: [
                    SortDescriptor(\VEvent.upcomingDate)
                ],
                visibility: .showAll
            )
            .modelContainer(container)
        }
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
