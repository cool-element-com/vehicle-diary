package com.cool.element.vehiclediary.domain

import java.util.UUID

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
    val uuid: String = UUID.randomUUID().toString(),
    val name: String,
    val brand: String,
    val model: String,
    val year: Int,
    val vin: String? = null,
    val licensePlate: String? = null,
    val purchasedDate: java.time.LocalDateTime? = null,
    val image: String? = null,
    val odometer: Int,
    val createdAt: java.time.LocalDateTime? = null,
    val updatedAt: java.time.LocalDateTime? = null,
    val events: Array<VEvent>? = null
) {
    companion object {
        fun sample(): Vehicle {
            val uuid = UUID.randomUUID().toString()
            val title = uuid.substring(0, 8)
            val vehicle = Vehicle(
                uuid = uuid,
                name = title,
                brand = "$title brand",
                model = "$title model",
                year = 2021,
                vin = "$title vin",
                licensePlate = "$title license plate",
                purchasedDate = java.time.LocalDateTime.now(),
                image = null,
                odometer = 1000,
                createdAt = java.time.LocalDateTime.now(),
                updatedAt = java.time.LocalDateTime.now(),
                events = null
            )
            return vehicle
        }
        private var stubVehicles = emptyList<Vehicle>()
        fun sampleList(quantity: Int = 10): List<Vehicle> {
            if (stubVehicles.isNotEmpty()) {
                return stubVehicles
            }
            val result = mutableListOf<Vehicle>()
            for (i in 0..quantity) {
                val vehicle = Vehicle.sample()
                result.add(vehicle)
            }
            stubVehicles = result
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