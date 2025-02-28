package com.cool.element.vehiclediary.presentation.screens.vehiclesList

import androidx.lifecycle.ViewModel
import com.cool.element.vehiclediary.data.StubVehicleRepository
import com.cool.element.vehiclediary.data.VehicleRepository
import com.cool.element.vehiclediary.domain.Vehicle
import kotlinx.coroutines.flow.Flow

interface VehiclesListViewModel {
    fun getAllVehicles() : Flow<List<Vehicle>>
    fun getVehicleById(id: Long) : Flow<Vehicle>
    suspend fun insertVehicle(vehicle: Vehicle)
    suspend fun updateVehicle(vehicle: Vehicle)
    suspend fun deleteVehicle(vehicle: Vehicle)
}

class FakeVehiclesListViewModelImpl(
    private val repository: VehicleRepository = StubVehicleRepository()
) : VehiclesListViewModel, ViewModel() {
    override fun getAllVehicles() : Flow<List<Vehicle>> {
        return repository.getAllVehicles()
    }

    override fun getVehicleById(id: Long) : Flow<Vehicle> {
        return repository.getVehicleById(id)
    }

    override suspend fun insertVehicle(vehicle: Vehicle) {
        repository.insertVehicle(vehicle)
    }

    override suspend fun updateVehicle(vehicle: Vehicle) {
        repository.updateVehicle(vehicle)
    }

    override suspend fun deleteVehicle(vehicle: Vehicle) {
        repository.deleteVehicle(vehicle)
    }
}
