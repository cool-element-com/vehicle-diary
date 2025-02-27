package com.cool.element.vehiclediary.presentation.navigation

import androidx.compose.runtime.Composable
import androidx.navigation.NavHostController
import androidx.navigation.NavType
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.navArgument
import com.cool.element.vehiclediary.presentation.Screen
import com.cool.element.vehiclediary.presentation.event.EventListView
import com.cool.element.vehiclediary.presentation.vehicle.VehicleListView
import com.cool.element.vehiclediary.presentation.vehicle.VehiclesListViewModel

@Composable
fun VehicleDiaryNavHost(
    viewModel: VehiclesListViewModel,
    navController: NavHostController
) {
    NavHost(
        navController = navController,
        startDestination = Screen.VehiclesListScreen.route
    ) {
        composable(Screen.VehiclesListScreen.route) {
            VehicleListView(
                viewModel = viewModel,
                navController = navController
            )
        }
        composable(
            route = Screen.EventsListScreen.route + "/{vehicleId}",
            arguments = listOf(
                navArgument(name = "vehicleId") {
                    type = NavType.LongType
                    defaultValue = 0L
                    nullable = false
                }
            )
        ) { entry ->
            val vehicleId: Long
            if (entry.arguments != null) {
                vehicleId = entry.arguments!!.getLong("vehicleId")
            } else {
                vehicleId = 0L
            }
            EventListView(
                vehicleId = vehicleId,
                navController = navController
            )
        }
    }
}
