package com.cool.element.vehiclediary.data
import com.cool.element.vehiclediary.domain.Vehicle
import com.cool.element.vehiclediary.domain.dao.VehicleDao
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.flow

interface VehicleRepository {
    fun getAllVehicles() : Flow<List<Vehicle>>
    fun getVehicleByUUID(uuid: String) : Flow<Vehicle>
    suspend fun insertVehicle(vehicle: Vehicle)
    suspend fun updateVehicle(vehicle: Vehicle)
    suspend fun deleteVehicle(vehicle: Vehicle)
}

class StubVehicleRepository : VehicleRepository {
    override fun getAllVehicles(): Flow<List<Vehicle>> {
        return flow { emit(Vehicle.sampleList()) }
    }

    override fun getVehicleByUUID(uuid: String): Flow<Vehicle> {
        return flow {
            emit(
                Vehicle.sampleList().first {
                    it.uuid == uuid
                }
            )
        }
    }

    override suspend fun insertVehicle(vehicle: Vehicle) {
        // no-op
    }

    override suspend fun updateVehicle(vehicle: Vehicle) {
        // no-op
    }

    override suspend fun deleteVehicle(vehicle: Vehicle) {
        // no-op
    }
}

class VehicleDaoRepository(
    private val vehicleDao: VehicleDao
) : VehicleRepository {
    override fun getAllVehicles() : Flow<List<Vehicle>> {
        return vehicleDao.getAllVehicles()
    }

    override fun getVehicleByUUID(uuid: String): Flow<Vehicle> {
        return vehicleDao.getVehicleByUUID(uuid)
    }

    override suspend fun insertVehicle(vehicle: Vehicle) {
        return vehicleDao.insertVehicle(vehicle)
    }

    override suspend fun updateVehicle(vehicle: Vehicle) {
        return vehicleDao.updateVehicle(vehicle)
    }

    override suspend fun deleteVehicle(vehicle: Vehicle) {
        return vehicleDao.deleteVehicle(vehicle)
    }
}

class FakeVehicleRepository : VehicleRepository {
    private val vehicles = mutableListOf<Vehicle>().apply { addAll(Vehicle.sampleList()) }

    override fun getAllVehicles(): Flow<List<Vehicle>> {
        return flow { emit(vehicles) }
    }

    override fun getVehicleByUUID(uuid: String): Flow<Vehicle> {
        return flow {
            val vehicle = vehicles.firstOrNull { it.uuid == uuid }
            if (vehicle != null) {
                emit(vehicle)
            } else {
                throw IllegalArgumentException("Vehicle not found id=$uuid")
            }
        }
    }

    override suspend fun insertVehicle(vehicle: Vehicle) {
        vehicles.add(vehicle)
    }

    override suspend fun updateVehicle(vehicle: Vehicle) {
        val index = vehicles.indexOfFirst { it.uuid == vehicle.uuid }
        if (index >= 0) {
            vehicles[index] = vehicle
        } else {
            throw IllegalArgumentException("Vehicle not found id=${vehicle.uuid}")
        }
    }

    override suspend fun deleteVehicle(vehicle: Vehicle) {
        vehicles.remove(vehicle)
    }
}