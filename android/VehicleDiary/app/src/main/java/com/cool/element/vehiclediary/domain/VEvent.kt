package com.cool.element.vehiclediary.domain

import java.util.UUID

/**
 *
 * @param id
 * @param title
 * @param amount
 * @param quantity
 * @param description
 * @param location
 * @param recordedDate
 * @param recordedMileage
 * @param upcomingDate
 * @param upcomingMileage
 * @param completedDate
 * @param completedMileage
 * @param isCompleted
 * @param vehicle
 */
data class VEvent (
    val uuid: kotlin.String,
    val title: kotlin.String,
    val amount: kotlin.Double? = null,
    val quantity: kotlin.Int? = null,
    val description: kotlin.String? = null,
    val location: kotlin.String? = null,
    val recordedDate: java.time.LocalDateTime,
    val recordedMileage: kotlin.Int,
    val upcomingDate: java.time.LocalDateTime,
    val upcomingMileage: kotlin.Int,
    val completedDate: java.time.LocalDateTime? = null,
    val completedMileage: kotlin.Int? = null,
    val isCompleted: kotlin.Boolean? = null,
    val vehicle: Vehicle
) {
    companion object {
        fun sampleForVehicle(
            vehicle: Vehicle = Vehicle.sample()
        ): VEvent {
            val uuid = UUID.randomUUID().toString()
            val title = uuid.substring(0, 5)
            val event = VEvent(
                uuid = uuid,
                title = "Event $title ",
                amount = 100.0,
                quantity = 1,
                description = "Event $title description",
                location = "Event $title location",
                recordedDate = java.time.LocalDateTime.now(),
                recordedMileage = 1000,
                upcomingDate = java.time.LocalDateTime.now(),
                upcomingMileage = 2000,
                completedDate = java.time.LocalDateTime.now(),
                completedMileage = 1500,
                isCompleted = false,
                vehicle = vehicle
            )
            return event
        }

        fun sampleListForVehicle(
            vehicle: Vehicle = Vehicle.sample(),
            quantity: Int = 10
        ): List<VEvent> {
            val result = mutableListOf<VEvent>()
            for (i in 0..quantity) {
                val event = sampleForVehicle(vehicle)
                result.add(event)
            }
            return result
        }
    }
}
