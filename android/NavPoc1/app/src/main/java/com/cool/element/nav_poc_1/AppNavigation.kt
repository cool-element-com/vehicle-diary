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
    /// TOFO: INVESTIGATE: Do we need to inject modifier from here?
    modifier: Modifier = Modifier
) {
    NavHost(
        navController = navController,
        startDestination = Screen.RecordListScreen.route
    ) {
        composable(Screen.RecordListScreen.route) {
            RecordsListView(
                viewModel = viewModel as? RecordsListViewModel
                    ?: StubRecordsListViewModel(),
                navController = navController
            )
        }

        // navigate to the RecordDetailScreen
        composable(Screen.RecordDetailsScreen.route) {
            RecordDetailsView(
                viewModel = viewModel as? RecordDetailsViewModel
                    ?: StubRecordDetailsViewModel(
                        record = DemoRecord.sample
                    ),
                navController = navController
            )
        }
    }
}
