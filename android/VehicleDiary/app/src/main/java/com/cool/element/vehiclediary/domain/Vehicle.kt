package com.cool.element.vehiclediary.domain

/**
 *
 * @param id
 * @param name
 * @param brand
 * @param model
 * @param year
 * @param vin
 * @param licensePlate
 * @param purchaseDate
 * @param image
 * @param odometer
 * @param createdAt
 * @param updatedAt
 * @param events
 */
data class Vehicle (

    val id: kotlin.Long,
    val name: kotlin.String,
    val brand: kotlin.String,
    val model: kotlin.String,
    val year: kotlin.Int,
    val vin: kotlin.String? = null,
    val licensePlate: kotlin.String? = null,
    val purchaseDate: java.time.LocalDateTime? = null,
    val image: kotlin.String? = null,
    val odometer: kotlin.Int,
    val createdAt: java.time.LocalDateTime? = null,
    val updatedAt: java.time.LocalDateTime? = null,
    val events: kotlin.Array<VEvent>? = null
) {
    companion object {
        val sample = Vehicle(
            id = 1000L,
            name = "Test vehicle",
            brand = "Test brand",
            model = "Test model",
            year = 2021,
            vin = "Test vin",
            licensePlate = "Test license plate",
            purchaseDate = java.time.LocalDateTime.now(),
            image = "Test image",
            odometer = 1000,
            createdAt = java.time.LocalDateTime.now(),
            updatedAt = java.time.LocalDateTime.now(),
            events = VEvent.sampleList.toTypedArray()
        )
        val sampleList: List<Vehicle>
            get() {
                val result = mutableListOf<Vehicle>()
                for (i in 0..10) {
                    val vehicle = Vehicle(
                        id = i.toLong(),
                        name = "Vehicle $i Name",
                        brand = "Vehicle $i Brand",
                        model = "Vehicle $i Model",
                        year = 2021,
                        vin = "Vehicle $i Vin",
                        licensePlate = "Vehicle $i License Plate",
                        purchaseDate = java.time.LocalDateTime.now(),
                        image = "Vehicle $i Image",
                        odometer = 1000,
                        createdAt = java.time.LocalDateTime.now(),
                        updatedAt = java.time.LocalDateTime.now(),
                        events = VEvent.sampleList.toTypedArray()
                    )
                    result.add(vehicle)
                }
                return result
            }
    }
}