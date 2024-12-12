package com.cool.element.vehiclediary.domain

data class Vehicle(
    val id: Long = 0L,
    val name: String = "",
    val brand: String = "",
    val model: String = "",
    val year: Int = 0,
    val color: String = "",
    val vin: String = "",
    val licensePlate: String = "",
    val purchaseDate: String = "",
    val purchasePrice: Double = 0.0,
    val odometer: Int = 0,
    val image: String = "",
    val events: List<VEvent> = mutableListOf()
) {
    companion object {
        val sample = Vehicle(
            id = 1000L,
            name = "Test vehicle",
            brand = "Test brand",
            model = "Test model",
            year = 2021,
            color = "Test color",
            vin = "Test vin",
            licensePlate = "Test license plate",
            purchaseDate = "2021-01-01",
            purchasePrice = 10000.0,
            odometer = 1000,
            image = "Test image",
            events = VEvent.sampleList.toMutableList()
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
                        color = "Vehicle $i Color",
                        vin = "Vehicle $i Vin",
                        licensePlate = "Vehicle $i License Plate",
                        purchaseDate = "2021-01-01",
                        purchasePrice = 10000.0,
                        odometer = 1000,
                        image = "Vehicle $i Image",
                        events = VEvent.sampleList.toMutableList()
                    )
                    result.add(vehicle)
                }
                return result
            }
    }
}
