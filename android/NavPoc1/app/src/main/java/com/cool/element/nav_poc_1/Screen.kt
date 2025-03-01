package com.cool.element.nav_poc_1

// Application Screens
sealed class Screen(val route: String) {
    object RecordListScreen : Screen(
        "record_list_screen"
    )
    object RecordDetailsScreen : Screen(
        "record_details_screen"
    )
}