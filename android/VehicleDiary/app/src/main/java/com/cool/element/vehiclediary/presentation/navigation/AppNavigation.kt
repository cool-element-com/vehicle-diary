package com.cool.element.vehiclediary.presentation.navigation

import androidx.compose.runtime.Composable
import androidx.navigation.NavHostController
import androidx.navigation.NavType
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.navArgument
import com.cool.element.vehiclediary.presentation.screens.Screen
import com.cool.element.vehiclediary.presentation.screens.eventsList.EventsListView
import com.cool.element.vehiclediary.presentation.screens.vehiclesList.VehicleListView
import com.cool.element.vehiclediary.presentation.screens.vehiclesList.VehiclesListViewModel

@Composable
fun AppNavigation(
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
            EventsListView(
                vehicleId = vehicleId,
                navController = navController
            )
        }
    }
}
