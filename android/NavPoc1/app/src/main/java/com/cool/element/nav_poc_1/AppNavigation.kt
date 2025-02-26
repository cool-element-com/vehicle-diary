package com.cool.element.nav_poc_1

import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.navigation.NavHostController
import androidx.navigation.compose.composable
import androidx.navigation.compose.NavHost


@Composable
fun AppNavigation(
    viewModel: AppViewModel,
    navController: NavHostController,
    modifier: Modifier = Modifier
) {
    NavHost(
        navController = navController,
        startDestination = Screen.RecordListScreen.route
    ) {
        composable(Screen.RecordListScreen.route) {
            DemoRecordsList(
                viewModel = viewModel as? DemoRecordsListViewModel
                    ?: StubDemoRecordsListViewModel(),
                navController = navController
            )
        }
    }
}
