package com.cool.element.vehiclediary.data
import com.cool.element.vehiclediary.domain.Vehicle
import com.cool.element.vehiclediary.domain.dao.VehicleDao
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.flow
import kotlinx.coroutines.launch

interface VehicleRepository {
    fun getAllVehicles() : Flow<List<Vehicle>>
    fun getVehicleByUUID(uuid: String) : Flow<Vehicle>
    fun insertVehicle(vehicle: Vehicle)
    fun updateVehicle(vehicle: Vehicle)
    fun deleteVehicle(vehicle: Vehicle)
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

    override fun insertVehicle(vehicle: Vehicle) {
        // no-op
    }

    override fun updateVehicle(vehicle: Vehicle) {
        // no-op
    }

    override fun deleteVehicle(vehicle: Vehicle) {
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

    override fun insertVehicle(vehicle: Vehicle) {
        GlobalScope.launch {
            vehicleDao.insertVehicle(vehicle)
        }
    }

    override fun updateVehicle(vehicle: Vehicle) {
        GlobalScope.launch {
            vehicleDao.updateVehicle(vehicle)
        }
    }

    override fun deleteVehicle(vehicle: Vehicle) {
        GlobalScope.launch {
            vehicleDao.deleteVehicle(vehicle)
        }
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

    override fun insertVehicle(vehicle: Vehicle) {
        vehicles.add(vehicle)
    }

    override fun updateVehicle(vehicle: Vehicle) {
        val index = vehicles.indexOfFirst { it.uuid == vehicle.uuid }
        if (index >= 0) {
            vehicles[index] = vehicle
        } else {
            throw IllegalArgumentException("Vehicle not found id=${vehicle.uuid}")
        }
    }

    override fun deleteVehicle(vehicle: Vehicle) {
        vehicles.remove(vehicle)
    }
}