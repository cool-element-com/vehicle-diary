package com.cool.element.vehiclediary.data
import com.cool.element.vehiclediary.domain.Vehicle
import com.cool.element.vehiclediary.domain.dao.VehicleDao
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.flow

interface VehicleRepository {
    fun getAllVehicles() : Flow<List<Vehicle>>
    fun getVehicleById(id: Long)
    suspend fun insertVehicle(vehicle: Vehicle)
}

class AppVehicleRepository(
    private val vehicleDao: VehicleDao
) : VehicleRepository {
    override fun getAllVehicles() : Flow<List<Vehicle>> {
        return vehicleDao.getAllVehicles()
    }

    override fun getVehicleById(id: Long): Flow<Vehicle> {
        return vehicleDao.getVehicleById(id)
    }

    override suspend fun insertVehicle(vehicle: Vehicle) {
        return vehicleDao.insertVehicle(vehicle)
    }
}

class FakeVehicleRepository : VehicleRepository {
    private val vehicles = mutableListOf<Vehicle>().apply { addAll(Vehicle.sampleList) }

    override fun getAllVehicles(): Flow<List<Vehicle>> {
        return flow { emit(vehicles) }
    }

    override fun getVehicleById(id: Long): Flow<Vehicle> {
        return flow {
            val vehicle = vehicles.firstOrNull { it.id == id }
            if (vehicle != null) {
                emit(vehicle)
            } else {
                throw IllegalArgumentException("Vehicle not found id=$id")
            }
        }
    }

    override suspend fun insertVehicle(vehicle: Vehicle) {
        vehicles.add(vehicle)
    }
}