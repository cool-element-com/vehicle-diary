package com.cool.element.vehiclediary

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.navigation.compose.rememberNavController
import com.cool.element.vehiclediary.presentation.navigation.VehicleDiaryNavHost
import com.cool.element.vehiclediary.presentation.vehicle.FakeVehiclesListViewModelImpl

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContent {
            VehicleDiaryNavHost(
                viewModel = FakeVehiclesListViewModelImpl(),
                navController = rememberNavController()
            )
        }
    }
}
