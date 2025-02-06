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
fun VehicleDiaryNavHost(navHostController: NavHostController) {
    NavHost(
        navController = navHostController,
        startDestination = Screen.VehiclesListScreen.route
    ) {
        composable(Screen.VehiclesListScreen.route) {
            VehicleListView(
                vehicles = Vehicle.sampleList,
                navController = navHostController
            )
        }
        composable(Screen.EventsListScreen.route) {
            EventListView(
                events = VEvent.sampleList,
                navController = navHostController
            )
        }
    }
}
