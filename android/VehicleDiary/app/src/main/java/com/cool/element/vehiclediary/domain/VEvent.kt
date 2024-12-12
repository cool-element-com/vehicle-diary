package com.cool.element.vehiclediary.domain

import java.time.LocalDateTime

data class VEvent(
    val id: Long = 0L,
    val title: String = "",
    val description: String = "",
    val recordedDate: LocalDateTime = LocalDateTime.now(),
    val recordedMileage: Double = 0.0,
    val upcomingDate: LocalDateTime = LocalDateTime.now(),
    val upcomingMileage: Double = 0.0,
    val completedDate: LocalDateTime = LocalDateTime.now(),
    val completedMileage: Double = 0.0,
    val isCompleted: Boolean = false,
    /// TODO: Add make relation to Vehicle
    /// - either via vehicleId or
    /// - vehicle reference
) {
    companion object {
        val sample = VEvent(
            id = 1000L,
            title = "Test event",
            description = "Test event description",
            recordedDate = LocalDateTime.now(),
            recordedMileage = 1000.0,
            upcomingDate = LocalDateTime.now(),
            upcomingMileage = 2000.0,
            completedDate = LocalDateTime.now(),
            completedMileage = 3000.0,
            isCompleted = false
        )
        val sampleList: List<VEvent>
            get() {
                val result = mutableListOf<VEvent>()
                for (i in 0..10) {
                    val event = VEvent(
                        id = i.toLong(),
                        title = "Event $i Title",
                        description = "Event $i Description",
                        recordedDate = LocalDateTime.now(),
                        recordedMileage = 1000.0,
                        upcomingDate = LocalDateTime.now(),
                        upcomingMileage = 2000.0,
                        completedDate = LocalDateTime.now(),
                        completedMileage = 3000.0,
                        isCompleted = false
                    )
                    result.add(event)
                }
                return result
            }
    }
}
