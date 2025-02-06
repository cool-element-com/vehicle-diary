package com.cool.element.vehiclediary

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.Scaffold
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.tooling.preview.Preview
import com.cool.element.vehiclediary.domain.Vehicle
import com.cool.element.vehiclediary.presentation.vehicle.VehicleListView
import com.cool.element.vehiclediary.ui.theme.VehicleDiaryTheme

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContent {
            VehicleDiaryAppStart()
        }
    }
}

@Composable
fun VehicleDiaryAppStart() {
    VehicleDiaryTheme {
        Scaffold(modifier = Modifier.fillMaxSize()) { innerPadding ->
            VehicleListView(
                vehicles = Vehicle.sampleList,
                modifier = Modifier.padding(innerPadding)
            )
        }
    }
}

@Preview(showBackground = true)
@Composable
fun VehicleDiaryAppStartPreview() {
    VehicleDiaryAppStart()
}
