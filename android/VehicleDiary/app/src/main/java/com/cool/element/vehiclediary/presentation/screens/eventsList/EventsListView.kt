package com.cool.element.vehiclediary.presentation.screens.eventsList

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
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.navigation.NavController
import com.cool.element.vehiclediary.domain.VEvent
import com.cool.element.vehiclediary.domain.Vehicle
import com.cool.element.vehiclediary.presentation.screens.Screen
import com.cool.element.vehiclediary.presentation.navigation.AppBarView
import com.cool.element.vehiclediary.utils.Constants

@Composable
fun EventsListView(
    vehicleUUID: String,
    navController: NavController,
    modifier: Modifier = Modifier
) {
    val context = LocalContext.current
    val vehicle: Vehicle = Vehicle.sampleList().firstOrNull {
        it.uuid == vehicleUUID
    } ?: Vehicle.sample()

    Scaffold(
        topBar = {
            AppBarView(
                title = "Vehicle ${vehicle.name}",
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
            items(vehicle.events ?: emptyArray()) { event ->
                EventRow(event = event)
                HorizontalDivider(
                    modifier = Modifier.padding(vertical = 8.dp),
                    thickness = 1.dp,
                    color = Color.Gray
                )
            }
        }
    }
    navController.navigate(Screen.VehiclesListScreen.route)
}

@Preview(showBackground = true)
@Composable
fun PreviewEventsListView() {
    EventsListView(
        vehicleUUID = Vehicle.sampleList().first().uuid,
        navController = NavController(LocalContext.current)
    )
}
