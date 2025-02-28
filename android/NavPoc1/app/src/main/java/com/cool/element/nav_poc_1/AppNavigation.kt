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
    /// TODO: INVESTIGATE: Do we need to inject modifier from here?
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

        composable(Screen.RecordDetailsScreen.route + "/{recordId}") { entry ->
            entry
                .arguments
                ?.getLong("recordId")
                ?.let { recordId ->
                    val detailsViewModel = viewModel as? RecordDetailsViewModel
                        ?: StubRecordDetailsViewModel(
                            recordId = recordId
                        )
                    detailsViewModel.setRecordId(recordId)

                    RecordDetailsView(
                        viewModel = detailsViewModel,
                        navController = navController
                    )
                }
        }
    }
}
