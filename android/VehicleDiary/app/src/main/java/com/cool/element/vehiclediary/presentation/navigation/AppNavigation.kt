package com.cool.element.vehiclediary.presentation.navigation

import android.util.Log
import androidx.compose.runtime.Composable
import androidx.navigation.NavHostController
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import com.cool.element.vehiclediary.domain.Vehicle
import com.cool.element.vehiclediary.presentation.screens.Screen
import com.cool.element.vehiclediary.presentation.screens.eventsList.EventsListView
import com.cool.element.vehiclediary.presentation.screens.vehiclesList.StubVehiclesListViewModel
import com.cool.element.vehiclediary.presentation.screens.vehiclesList.VehiclesListView
import com.cool.element.vehiclediary.presentation.screens.vehiclesList.VehiclesListViewModel
import kotlin.math.log

@Composable
fun AppNavigation(
    viewModel: AppViewModel,
    navController: NavHostController
) {
    NavHost(
        navController = navController,
        startDestination = Screen.VehiclesListScreen.route
    ) {
        composable(Screen.VehiclesListScreen.route) {
            VehiclesListView(
                viewModel = viewModel as? VehiclesListViewModel
                ?: StubVehiclesListViewModel(),
                navController = navController
            )
        }

        composable(Screen.EventsListScreen.route + "/{uuid}") { entry ->
            entry
                .arguments
                ?.getString("uuid")
                ?.let { uuid ->
                    val vehicle: Vehicle = Vehicle.sampleList()
                        .firstOrNull { it.uuid == uuid }
                        ?: Vehicle.unknown()
                    Log.d(
                        "AppNavigation",
                        "Navigating to: ${vehicle.name} events screen"
                    )
                    EventsListView(
                        vehicle = vehicle,
                        navController = navController
                    )
                }
        }
    }
}
