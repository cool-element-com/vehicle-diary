package com.cool.element.vehiclediary.presentation.navigation

import androidx.compose.runtime.Composable
import androidx.lifecycle.viewmodel.compose.viewModel
import androidx.navigation.NavHostController
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import com.cool.element.vehiclediary.presentation.Screen
import com.cool.element.vehiclediary.presentation.event.EventListView
import com.cool.element.vehiclediary.presentation.vehicle.VehicleListView
import com.cool.element.vehiclediary.domain.VEvent
import com.cool.element.vehiclediary.presentation.vehicle.VehiclesListViewModel

@Composable
fun VehicleDiaryNavHost(
    viewModel: VehiclesListViewModel = viewModel(),
    navController: NavHostController = rememberNavController()
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
        composable(Screen.EventsListScreen.route) {
            EventListView(
                events = VEvent.sampleList,
                navController = navController
            )
        }
    }
}
