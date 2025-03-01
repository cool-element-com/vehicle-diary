package com.cool.element.vehiclediary.presentation.screens.vehiclesList

import androidx.lifecycle.ViewModel
import com.cool.element.vehiclediary.data.StubVehicleRepository
import com.cool.element.vehiclediary.data.VehicleRepository
import com.cool.element.vehiclediary.domain.Vehicle
import com.cool.element.vehiclediary.presentation.navigation.AppViewModel
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.flow

interface VehiclesListViewModel : AppViewModel {
    fun getAllVehicles(): List<Vehicle>
    fun getVehicleByUUID(uuid: String): Vehicle
    fun insertVehicle(vehicle: Vehicle)
    fun updateVehicle(vehicle: Vehicle)
    fun deleteVehicle(vehicle: Vehicle)
}

class StubVehiclesListViewModel(
//    private val repository: VehicleRepository = StubVehicleRepository()
) : VehiclesListViewModel, ViewModel() {
    override fun getAllVehicles(): List<Vehicle> {
        return Vehicle.sampleList()
    }

    override fun getVehicleByUUID(uuid: String): Vehicle {
        return Vehicle.sampleList().firstOrNull {
            it.uuid == uuid
        } ?: Vehicle.unknown()
    }

    override fun insertVehicle(vehicle: Vehicle) {
        // no op
    }

    override fun updateVehicle(vehicle: Vehicle) {
        // no op
    }

    override fun deleteVehicle(vehicle: Vehicle) {
        // no op
    }
}
