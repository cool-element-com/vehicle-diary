package com.cool.element.vehiclediary.presentation

sealed class Screen(val route: String) {
    object VehiclesListScreen: Screen("VehiclesListScreen")
    object AddVehicleScreen: Screen("AddVehicleScreen")
    object EditVehicleScreen: Screen("EditVehicleScreen")
    object EventsListScreen: Screen("EventsListScreen")
    object AddEventScreen: Screen("AddEventScreen")
    object EditEventScreen: Screen("EditEventScreen")
}