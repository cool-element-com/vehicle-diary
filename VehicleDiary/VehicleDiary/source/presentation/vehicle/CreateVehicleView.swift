//
//  CreateVehicleView.swift
//  VehicleDiary
//
//  Created by boyan.yankov on 2024-06-14.
//

import SwiftUI
import SwiftData

struct CreateVehicleView: View {
    @Environment(\.locale) private var locale
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss

    @State private var brand: String = ""
    @State private var model: String = ""
    @State private var comment: String = ""
    @State private var millage: Double? = nil

    var body: some View {
        NavigationStack {
            Form {
                TextField("Brand", text: $brand)
                TextField("Model", text: $model)
                TextField("Comment (optional)", text: $comment)
                TextField("Millage", value: $millage, format: .number)
                    .keyboardType(.numberPad)
            }
            .keyboardType(.asciiCapable)
            .navigationTitle("Create Vehicle")
            .navigationBarTitleDisplayMode(.inline)

            Button("Create") {
                createVehicle()
            }
            .buttonStyle(.borderedProminent)
            .disabled(
                brand.isEmpty
                ||
                model.isEmpty
                ||
                millage == nil
                ||
                millage == 0
            )
        }
        .dynamicTypeSize(...DynamicTypeSize.large)
    }

    private func createVehicle() {
        let vehicle = Vehicle(
            brand: brand,
            model: model,
            comment: comment.isEmpty ? nil : comment,
            millage: millage,
            id: UUID().uuidString
        )
        modelContext.insert(vehicle)
        dismiss()
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Vehicle.self, migrationPlan: .none, configurations: config)

        return CreateVehicleView()
                .modelContainer(container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
