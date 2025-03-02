package com.cool.element.vehiclediary.presentation.screens

sealed class Screen(val route: String) {
    object VehiclesListScreen: Screen("VehiclesListScreen")
    object AddVehicleScreen: Screen("AddVehicleScreen")
    object EditVehicleScreen: Screen("EditVehicleScreen")
    object EventsListScreen: Screen("EventsListScreen")
    object EventDetailsScreen: Screen("EventDetailsScreen")
    object AddEventScreen: Screen("AddEventScreen")
    object EditEventScreen: Screen("EditEventScreen")
    object SettingsScreen: Screen("SettingsScreen")
    object EventScreen: Screen("EventScreen")
}
