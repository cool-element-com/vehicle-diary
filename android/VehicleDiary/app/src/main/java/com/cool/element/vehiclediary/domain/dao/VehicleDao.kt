package com.cool.element.vehiclediary.domain.dao

import androidx.room.Dao
import androidx.room.Delete
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import androidx.room.Update
import com.cool.element.vehiclediary.domain.Vehicle
import kotlinx.coroutines.flow.Flow

@Dao
abstract class VehicleDao {
    @Insert(onConflict = OnConflictStrategy.REPLACE)
    abstract suspend fun insertVehicle(entity: Vehicle)

    @Query("Select * from `vehicle-table`")
    abstract fun getAllVehicles() : Flow<List<Vehicle>>

    @Update
    abstract suspend fun updateVehicle(entity: Vehicle)

    @Delete
    abstract suspend fun deleteVehicle(entity: Vehicle)

    @Query("Select * from `vehicle-table` where uuid=:uuid")
    abstract fun getVehicleByUUID(uuid: String) : Flow<Vehicle>
}