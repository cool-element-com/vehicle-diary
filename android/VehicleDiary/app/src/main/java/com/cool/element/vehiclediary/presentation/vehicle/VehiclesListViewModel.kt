package com.cool.element.vehiclediary.presentation.vehicle

import androidx.lifecycle.ViewModel
import com.cool.element.vehiclediary.data.FakeVehicleRepository
import com.cool.element.vehiclediary.data.VehicleRepository
import com.cool.element.vehiclediary.domain.Vehicle

interface VehiclesListViewModel {
    fun getAllVehicles()
    fun getVehicleById(id: Long)
    suspend fun insertVehicle(vehicle: Vehicle)
    suspend fun updateVehicle(vehicle: Vehicle)
    suspend fun deleteVehicle(vehicle: Vehicle)
}

class VehiclesListViewModelImpl(
    private val repository: VehicleRepository = FakeVehicleRepository()
) : VehiclesListViewModel, ViewModel() {
    override fun getAllVehicles() {
        repository.getAllVehicles()
    }

    override fun getVehicleById(id: Long) {
        repository.getVehicleById(id)
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
