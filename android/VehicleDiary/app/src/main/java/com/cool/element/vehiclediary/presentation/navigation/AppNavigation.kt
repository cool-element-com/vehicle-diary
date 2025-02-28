package com.cool.element.vehiclediary.presentation.navigation

import androidx.compose.runtime.Composable
import androidx.navigation.NavHostController
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
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

        composable(Screen.EventsListScreen.route + "/{vehicleUUID}") { entry ->
            entry
                .arguments
                ?.getString("vehicleUUID")
                ?.let { uuid ->
                    EventsListView(
                        vehicleUUID = uuid,
                        navController = navController
                    )
                }
        }
    }
}
