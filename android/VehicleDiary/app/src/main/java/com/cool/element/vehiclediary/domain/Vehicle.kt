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
    val id: Long,
    val name: String,
    val brand: String,
    val model: String,
    val year: Int,
    val vin: String? = null,
    val licensePlate: String? = null,
    val purchaseDate: java.time.LocalDateTime? = null,
    val image: String? = null,
    val odometer: Int,
    val createdAt: java.time.LocalDateTime? = null,
    val updatedAt: java.time.LocalDateTime? = null,
    val events: Array<VEvent>? = null
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
            image = null,
            odometer = 1000,
            createdAt = java.time.LocalDateTime.now(),
            updatedAt = java.time.LocalDateTime.now(),
            events = null
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
                        image = null,
                        odometer = 1000,
                        createdAt = java.time.LocalDateTime.now(),
                        updatedAt = java.time.LocalDateTime.now(),
                        events = null
                    )
                    result.add(vehicle)
                }
                return result
            }
    }

    override fun equals(other: Any?): Boolean {
        if (this === other) return true
        if (javaClass != other?.javaClass) return false

        other as Vehicle

        if (name != other.name) return false
        if (brand != other.brand) return false
        if (model != other.model) return false
        if (year != other.year) return false
        if (vin != other.vin) return false

        return true
    }

    override fun hashCode(): Int {
        var result = name.hashCode()
        result = 31 * result + brand.hashCode()
        result = 31 * result + model.hashCode()
        result = 31 * result + year
        result = 31 * result + (vin?.hashCode() ?: 0)
        return result
    }
}