//
//  EventView.swift
//  VehicleDiary
//
//  Created by boyan.yankov on 2024-06-17.
//

import SwiftUI
import SwiftData

struct EventView: View {
    @Environment(\.locale) var locale
    let event: VEvent
    @State private var isShowingEditView = false

    var body: some View {
        VStack {
            Form {
                Text(event.name)
                Text(event.comment ?? "")

                Section("Recorded") {
                    HStack {
                        Text("Date")
                        Spacer()
                        Text(event.recordedDateString())
                    }
                    HStack {
                        Text("Millage")
                        Spacer()
                        Text(event.recordedMillage != nil
                            ? event.recordedMillageMeasurement
                            .formatted(
                                .measurement(
                                    width: .abbreviated,
                                    usage: .road)
                                .locale(locale)
                            )
                            : "-"
                        )
                    }
                }

                Section("Next Occurrence") {
                    HStack {
                        Text("Date")
                        Spacer()
                        Text(event.nextDate != nil 
                             ? event.nextDateString()
                             : "-"
                        )
                    }
                    HStack {
                        Text("Millage")
                        Spacer()
                        Text(event.nextMillage != nil
                             ? event.nextMillageMeasurement.formatted(
                                .measurement(
                                    width: .abbreviated,
                                    usage: .road)
                                .locale(locale)
                             )
                             : "-"
                        )
                    }
                }
            }
            .navigationTitle(event.name)
            .navigationBarTitleDisplayMode(.inline)

            Button("Edit") {
                isShowingEditView = true
            }
            .padding()
            .buttonStyle(.borderedProminent)
        }
        .sheet(isPresented: $isShowingEditView, content: {
            EditEventView(event: event)
        })
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
            millage: 12345,
            id: UUID().uuidString
        )
        let event = VEvent(
            name: "Test Event",
            comment: "Test comment",
            recordedDate: Date.now,
            nextDate: nil,
            recordedMillage: 10_000,
            nextMillage: 20_000,
            id: UUID().uuidString,
            vehicle: vehicle
        )
        return NavigationStack {
            EventView(event: event)
                .modelContainer(container)
        }
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
