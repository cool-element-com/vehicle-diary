package com.cool.element.vehiclediary.presentation

import androidx.compose.foundation.Image
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import coil.compose.rememberAsyncImagePainter
import com.cool.element.vehiclediary.domain.Vehicle

@Composable
fun VehicleListView(
    vehicles: List<Vehicle>,
    modifier: Modifier = Modifier
) {
    LazyColumn(
        modifier = modifier
            .fillMaxSize()
            .padding(16.dp)
    ) {
        items(vehicles) { vehicle ->
            VehicleRow(vehicle = vehicle)
            HorizontalDivider(
                modifier = Modifier.padding(vertical = 8.dp),
                thickness = 1.dp,
                color = Color.Gray
            )
        }
    }
}

@Composable
fun VehicleRow(vehicle: Vehicle) {
    Row(
        modifier = Modifier
            .fillMaxWidth()
            .padding(8.dp)
            .clickable { /* Handle click */ },
        verticalAlignment = Alignment.CenterVertically
    ) {
        Image(
            painter = rememberAsyncImagePainter(vehicle.image ?: ""),
            contentDescription = null,
            modifier = Modifier
                .size(60.dp)
                .clip(CircleShape),
            contentScale = ContentScale.Crop
        )
        Spacer(modifier = Modifier.width(16.dp))
        Column {
            Text(text = vehicle.name, fontWeight = FontWeight.Bold, fontSize = 20.sp)
            Text(text = "${vehicle.brand} ${vehicle.model} (${vehicle.year})", color = Color.Gray)
            Text(text = "Odometer: ${vehicle.odometer} km", color = Color.Gray, fontSize = 12.sp)
        }
    }
}

//@Composable
//fun EventRow(event: VEvent) {
//    Column(
//        modifier = Modifier
//            .fillMaxWidth()
//            .padding(8.dp)
//    ) {
//        Text(text = event.title, fontWeight = FontWeight.Bold, fontSize = 16.sp)
//        Text(text = "Location: ${event.location}", fontSize = 14.sp)
//        Text(text = "Recorded Date: ${event.recordedDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"))}", fontSize = 12.sp, color = Color.Gray)
//        if (event.isCompleted == true) {
//            Text(text = "Completed", color = Color.Green, fontSize = 12.sp)
//        } else {
//            Text(text = "Upcoming: ${event.upcomingDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"))}", fontSize = 12.sp, color = Color.Red)
//        }
//    }
//}

@Preview(showBackground = true)
@Composable
fun PreviewVehicleListView() {
    val vehicles = Vehicle.sampleList

    VehicleListView(vehicles = vehicles)
}
