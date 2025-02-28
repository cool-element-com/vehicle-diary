package com.cool.element.vehiclediary.presentation.screens.vehiclesList

import android.util.Log
import android.widget.Toast
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.offset
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material3.HorizontalDivider
import androidx.compose.material3.Scaffold
import androidx.compose.runtime.Composable
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.navigation.NavController
import com.cool.element.vehiclediary.presentation.screens.Screen
import com.cool.element.vehiclediary.presentation.navigation.AppBarView
import com.cool.element.vehiclediary.utils.Constants

@Composable
fun VehicleListView(
    viewModel: VehiclesListViewModel,
    navController: NavController,
    modifier: Modifier = Modifier
) {
    val context = LocalContext.current
    val vehicles by viewModel.getAllVehicles().collectAsState(initial = emptyList())

    Scaffold(
        topBar = {
            AppBarView(
                title = Constants.ViewTitle.vehicles,
                onBackButtonTapped = {
                    Toast
                        .makeText(
                            context,
                            "Back button tapped",
                            Toast.LENGTH_LONG
                        )
                        .show()
                }
            )
        }
    ) { paddingValues ->
        Log.d(
            Constants.LogTag.debug,
            "paddingValues: $paddingValues"
        )
        LazyColumn(
            modifier = modifier
                .fillMaxSize()
                .padding(16.dp)
                .offset(y = 48.dp)
        ) {
            items(vehicles) { vehicle ->
                VehicleRow(
                    vehicle = vehicle,
                    onClick = {
                        navController
                            .navigate(
                                route =  Screen.EventsListScreen.route + "/${vehicle.id}"
//                                route = Screen.EventsListScreen.route
                            )
                    }
                )
                HorizontalDivider(
                    modifier = Modifier.padding(vertical = 8.dp),
                    thickness = 1.dp,
                    color = Color.Gray
                )
            }
        }
    }
}

@Preview(showBackground = true)
@Composable
fun PreviewVehicleListView() {
    val viewModel = FakeVehiclesListViewModelImpl()

    VehicleListView(
        viewModel = viewModel,
        navController = NavController(LocalContext.current)
    )
}
