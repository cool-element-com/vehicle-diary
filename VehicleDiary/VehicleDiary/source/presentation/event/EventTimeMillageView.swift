//
//  EventTimeMileageView.swift
//  VehicleDiary
//
//  Created by boyan.yankov on 2024-06-17.
//

import SwiftUI
import SwiftData

struct EventTimeMileageView: View {
    enum Occurrence {
        case recorded
        case upcoming
        case completed
    }

    private var textColor: Color {
        Theme.default.defaultConfig.textColor
    }

    @Environment(\.locale) private var locale
    private let viewModel: ViewModel

    init(
        event: VEvent,
        occurrence: Occurrence
    ) {
        self.viewModel = ViewModel(
            event: event,
            occurrence: occurrence
        )
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .firstTextBaseline) {
                Text("date".uppercased())
                    .font(.caption2)
                    .fontWeight(.light)
                    .foregroundStyle(textColor)
                Spacer()
                Text(viewModel.dateString)
                    .foregroundStyle(textColor)
            }
            .font(.caption)
            .fontWeight(.medium)

            HStack(alignment: .firstTextBaseline) {
                Text("mileage".uppercased())
                    .font(.caption2)
                    .fontWeight(.light)
                    .foregroundStyle(textColor)
                Spacer()
                Text(viewModel.mileageMeasurementString)
                    .foregroundStyle(textColor)
            }
            .font(.caption)
            .fontWeight(.medium)
        }
        .dynamicTypeSize(...DynamicTypeSize.large)
        .padding(.vertical, 0)
    }
}

extension EventTimeMileageView {
    fileprivate struct ViewModel {
        let event: VEvent
        let occurrence: EventTimeMileageView.Occurrence

        var dateString: String {
            let result: String
            switch occurrence {
            case .recorded:
                result = event.recordedDateString()
            case .upcoming:
                result = event.upcomingDateString()
            case .completed:
                result = event.completedDateString()
            }
            return result
        }

        var mileageMeasurementString: String {
            let result: String
            switch occurrence {
            case .recorded:
                result = event.recordedMileageMeasurementString()
            case .upcoming:
                result = event.upcomingMileageMeasurementString()
            case .completed:
                result = event.completedMileageMeasurementString()
            }
            return result
        }
        var backgroundColor: Color {
            let color: Color
            switch occurrence {
            case .recorded:
                color = Color(uiColor: .lightGray)
            case .upcoming:
                let approaching: [VEvent.Approach] = [
                    .inDays,
                    .afterMileage,
                    .bothDaysAndMileage
                ]

                if approaching.contains(event.approach) {
                    color = .red
                } else {
                    color = .green
                }
            case .completed:
                color = Color(uiColor: .darkGray)
            }
            return color
        }
    }
}

#Preview("EventTimeMileageView") {
    let event = VEvent(name: "Test Name", recordedDate: .now)
    VStack {
        EventTimeMileageView(event: event, occurrence: .completed)
        EventTimeMileageView(event: event, occurrence: .upcoming)
        EventTimeMileageView(event: event, occurrence: .recorded)
    }

}

#Preview("upcoming EventTimeMileageView") {
    let event = VEvent(name: "Test Name", recordedDate: .now)
    EventTimeMileageView(event: event, occurrence: .upcoming)
}

#Preview("recorded EventTimeMileageView") {
    let event = VEvent(name: "Test Name", recordedDate: .now)
    EventTimeMileageView(event: event, occurrence: .recorded)
}

#Preview("completed EventTimeMileageView") {
    let event = VEvent(name: "Test Name", recordedDate: .now)
    EventTimeMileageView(event: event, occurrence: .completed)
}

#Preview("2 events in a list") {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Vehicle.self, migrationPlan: .none, configurations: config)
        let vehicle = Vehicle(
            brand: "Subaru",
            model: "Outback",
            comment: "hello",
            mileage: 10000,
            id: UUID().uuidString
        )
        container.mainContext.insert(vehicle)

        for number in 0..<2 {
            let numberDouble = Double(number)
            let event = VEvent(
                name: "Event \(number)",
                comment: number.isMultiple(of: 2) ? """
this is a comment for a long event, new line is also very important new line is also very important, new line is also very important
as third line as well
""" : nil,
                recordedDate: Date.init(timeIntervalSinceNow: Double.random(in: 100000...1000000) * numberDouble),
                upcomingDate: nil,
                recordedMileage: number.isMultiple(of: 2)
                ? (Double.random(in: 5000...12000) + 123 * numberDouble)
                : nil,
                upcomingMileage: number.isMultiple(of: 2)
                ? Double.random(in: 10000...10200) + 123 * numberDouble
                : nil,
                isCompleted: false)
            vehicle.events?.append(event)
        }

        return List {
            ForEach(vehicle.events ?? []) { event in
                return EventRowView(event: event)
            }
        }
        .modelContainer(container)
        .listStyle(.plain)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
