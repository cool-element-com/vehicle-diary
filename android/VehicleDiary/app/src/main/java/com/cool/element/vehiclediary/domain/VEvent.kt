package com.cool.element.vehiclediary.domain

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
    val id: kotlin.Long,
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
        val sample = VEvent(
            id = 1000L,
            title = "Test event",
            amount = 100.0,
            quantity = 1,
            description = "Test event description",
            location = "Test location",
            recordedDate = java.time.LocalDateTime.now(),
            recordedMileage = 1000,
            upcomingDate = java.time.LocalDateTime.now(),
            upcomingMileage = 2000,
            completedDate = java.time.LocalDateTime.now(),
            completedMileage = 1500,
            isCompleted = false,
            vehicle = Vehicle.sample
        )
        val sampleList: List<VEvent>
            get() {
                val result = mutableListOf<VEvent>()
                for (i in 0..10) {
                    val event = VEvent(
                        id = i.toLong(),
                        title = "Event $i Title",
                        amount = 100.0,
                        quantity = 1,
                        description = "Event $i Description",
                        location = "Event $i Location",
                        recordedDate = java.time.LocalDateTime.now(),
                        recordedMileage = 1000,
                        upcomingDate = java.time.LocalDateTime.now(),
                        upcomingMileage = 2000,
                        completedDate = java.time.LocalDateTime.now(),
                        completedMileage = 1500,
                        isCompleted = false,
                        vehicle = Vehicle.sample
                    )
                    result.add(event)
                }
                return result
            }
    }
}
