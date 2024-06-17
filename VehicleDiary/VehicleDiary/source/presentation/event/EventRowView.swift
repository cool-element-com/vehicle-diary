//
//  EventRowView.swift
//  VehicleDiary
//
//  Created by boyan.yankov on 2024-06-16.
//

import SwiftUI
import SwiftData

enum AlignmentSample {
    enum MidAccountAndName: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[.top]
        }
    }

    static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
}

struct EventRowView: View {
    @Environment(\.locale) private var locale
    let event: VEvent

    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text(event.name)
                    .font(.title2.bold())
                if !event.unwrappedComment.isEmpty {
                    Text(event.unwrappedComment)
                        .font(.caption)
                }
            }
            .padding(.vertical, 0)

            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text("Recorded".uppercased())
                        .padding(.vertical, 2)
                        .font(.caption2)
                    HStack(alignment: .firstTextBaseline) {
                        Text("date".uppercased())
                            .font(.caption)
                        Spacer()
                        Text(event.dateString())
                    }
                    HStack(alignment: .firstTextBaseline) {
                        Text("millage".uppercased())
                            .font(.caption)
                        Spacer()
                        if event.recordedMillage != nil {
                            Text(event.recordedMillageMeasurement.formatted(
                                .measurement(
                                    width: .abbreviated,
                                    usage: .road
                                ).locale(locale)
                            ))
                        } else {
                            Text("-")
                        }
                    }
                }
                .frame(height: 60)
                .padding(8)
                .background(content: {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.blue.opacity(0.25))
                })


                VStack(alignment: .trailing) {
                    Text("Next".uppercased())
                        .font(.caption2)
                        .padding(.vertical, 2)
                    HStack(alignment: .firstTextBaseline) {
                        Text("date".uppercased())
                            .font(.caption)
                        Spacer()
                        VStack(alignment: .trailing) {
                            if event.nextDate != nil {
                                Text(event.nextDateString())
                            } else {
                                Text("-")
                            }
                        }
                    }
                    HStack(alignment: .firstTextBaseline) {
                        Text("millage".uppercased())
                            .font(.caption)
                        Spacer()
                        if event.nextMillage != nil {
                            Text(event.nextMillageMeasurement.formatted(
                                .measurement(
                                    width: .abbreviated,
                                    usage: .road
                                ).locale(locale)
                            ))
                        } else {
                            Text("-")
                        }
                    }

                }
                .frame(height: 60)
                .padding(8)
                    .background(content: {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.orange.opacity(0.25))
                    })
            }
        }
        .dynamicTypeSize(...DynamicTypeSize.large)
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Vehicle.self, migrationPlan: .none, configurations: config)
        return List {
            ForEach(0..<20, id: \.self) { number in
                let numberDouble = Double(number)
                let event = VEvent(
                    name: "Event \(number)",
                    comment: number.isMultiple(of: 2) ? "Comment \(number)" : nil,
                    recordedDate: Date.init(timeIntervalSinceNow: 100 * numberDouble),
                    nextDate: /*number.isMultiple(of: 3) ? Date(timeIntervalSinceNow: 100_000_000 + 1000 * numberDouble) : */nil,
                    recordedMillage: number.isMultiple(of: 4) ? (1234 + 123 * numberDouble) : nil,
                    nextMillage: number.isMultiple(of: 5) ? 10000 + 123 * numberDouble : nil)
                return EventRowView(event: event)
                    .modelContainer(container)
            }
        }
        .listStyle(.plain)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
