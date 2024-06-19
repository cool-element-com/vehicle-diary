//
//  EditVehicleView.swift
//  VehicleDiary
//
//  Created by boyan.yankov on 2024-06-14.
//

import SwiftUI
import SwiftData

struct EditVehicleView: View {
    @Environment(\.dismiss) var dismiss
    @Bindable var vehicle: Vehicle

    @State private var brand: String
    @State private var model: String
    @State private var comment: String
    /// for some reason when using `Double` for `mileage`
    /// when `TextField` content is deleted
    /// button stays active
    @State private var mileage: String

    var body: some View {
        NavigationStack {
            Form {
                TextField("Brand", text: $brand)
                TextField("Model", text: $model)
                TextField("Comment (optional)", text: $comment)
                TextField("Mileage", text: $mileage)
                    .keyboardType(.numberPad)
            }
            .navigationTitle("Edit Vehicle")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Update") {
                        update(vehicle)
                    }
                    .padding(.horizontal, 10)
                    .disabled(
                        brand.isEmpty
                        ||
                        model.isEmpty
                        ||
                        mileage.isEmpty
                        ||
                        Double(mileage) == nil
                        ||
                        Double(mileage) ?? 0 < 0
                    )
                }
            }
        }
        .dynamicTypeSize(...DynamicTypeSize.large)
    }

    init(vehicle: Vehicle) {
        self.vehicle = vehicle
        brand = vehicle.brand
        model = vehicle.model
        comment = vehicle.comment ?? ""
        mileage = String(format: "%.0f", vehicle.mileage ?? 0)
    }

    private func update(_ vehicle: Vehicle) {
        vehicle.brand = brand
        vehicle.model = model
        vehicle.comment = comment
        vehicle.mileage = Double(mileage) ?? 0

        dismiss()
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Vehicle.self, migrationPlan: .none, configurations: config)
        let vehicle = Vehicle(
            brand: "Subaru",
            model: "Outback",
            comment: "hello",
            mileage: 12345,
            id: UUID().uuidString
        )
        return EditVehicleView(vehicle: vehicle)
                .modelContainer(container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
