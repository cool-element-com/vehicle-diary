package com.cool.element.vehiclediary.presentation.navigation

import androidx.compose.runtime.Composable
import androidx.navigation.NavHostController
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import com.cool.element.vehiclediary.presentation.Screen
import com.cool.element.vehiclediary.presentation.event.EventListView
import com.cool.element.vehiclediary.presentation.vehicle.VehicleListView
import com.cool.element.vehiclediary.domain.Vehicle
import com.cool.element.vehiclediary.domain.VEvent

@Composable
fun VehicleDiaryNavHost(navController: NavHostController) {
    NavHost(
        navController = navController,
        startDestination = Screen.VehiclesListScreen.route
    ) {
        composable(Screen.VehiclesListScreen.route) {
            VehicleListView(
                vehicles = Vehicle.sampleList,
                navController = navController
            )
        }
        composable(Screen.EventsListScreen.route) {
            EventListView(
                events = VEvent.sampleList,
                navController = navController
            )
        }
    }
}
