package com.cool.element.vehiclediary

import android.os.Bundle
import android.util.Log
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material3.Scaffold
import androidx.compose.ui.Modifier
import androidx.navigation.compose.rememberNavController
import com.cool.element.vehiclediary.presentation.navigation.AppNavigation
import com.cool.element.vehiclediary.presentation.screens.vehiclesList.StubVehiclesListViewModel
import com.cool.element.vehiclediary.ui.theme.VehicleDiaryTheme

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContent {
            VehicleDiaryTheme {
                Scaffold(modifier = Modifier.fillMaxSize()) { innerPadding ->
                    Log.d(
                        "MainActivity",
                        "innerPadding: $innerPadding"
                    )
                    AppNavigation(
                        viewModel = StubVehiclesListViewModel(),
                        navController = rememberNavController()
                    )
                }
            }
        }
    }
}
