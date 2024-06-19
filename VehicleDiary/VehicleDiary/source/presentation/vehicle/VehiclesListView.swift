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
    
    @State private var isShowingCreateVehicle = false
    @State private var isShowingDeleteAlert = false
    @State private var deleteVehicle: Vehicle?
    @State private var editVehicle: Vehicle?

    var body: some View {
        NavigationStack() {
            List {
                ForEach(vehicles) { vehicle in
                    NavigationLink(value: vehicle) {
                        VehicleRowView(vehicle: vehicle)
                    }
                    .swipeActions(edge: .leading, allowsFullSwipe: true) {
                        Button {
                            editVehicle = vehicle
                        } label: {
                            Label("Edit Vehicle", systemImage: "square.and.pencil")
                        }
                        .tint(.green)
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button {
                            deleteVehicle = vehicle
                            isShowingDeleteAlert = true
                        } label: {
                            Label("Delete Vehicle", systemImage: "trash")
                        }
                        .tint(.red)
                    }
                }
            }
            .navigationDestination(for: Vehicle.self) { vehicle in
                EventsListView(vehicle: vehicle)
            }
            .listStyle(.plain)
            .navigationTitle("Vehicles")
            .toolbar {
                Button("Create Vehicle", systemImage: "plus") {
                    isShowingCreateVehicle.toggle()
                }
            }
            .sheet(isPresented: $isShowingCreateVehicle) {
                CreateVehicleView()
            }
            .sheet(item: $editVehicle) { value in
                EditVehicleView(vehicle: value)
            }
            .alert("Delete Vehicle", isPresented: $isShowingDeleteAlert) {
                Button("Cancel", role: .cancel, action: {})
                Button("Delete", role: .destructive, action: {
                    deleteVehicle(deleteVehicle)
                })
            } message: {
                Text("All events associated with that vehicle will be deleted. Are you sure?")
            }
        }
        .dynamicTypeSize(...DynamicTypeSize.large)
    }

    private func deleteVehicle(_ vehicle: Vehicle?) {
        guard let vehicle else {
            return
        }
        modelContext.delete(vehicle)
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Vehicle.self, migrationPlan: .none, configurations: config)
        for number in 0..<20 {
            let vehicle = Vehicle(
                brand: "Subaru",
                model: "Outback",
                comment: number.isMultiple(of: 2) ? "Comment \(number)" : nil ,
                mileage: 14503 + 1234 * Double(number),
                id: UUID().uuidString
            )
            container.mainContext.insert(vehicle)
        }

        return VehiclesListView()
            .modelContainer(container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
