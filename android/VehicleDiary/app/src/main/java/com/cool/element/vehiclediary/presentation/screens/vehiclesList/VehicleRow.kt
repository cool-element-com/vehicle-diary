package com.cool.element.vehiclediary.presentation.screens.vehiclesList

import android.util.Log
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.graphicsLayer
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import coil.compose.AsyncImage
import com.cool.element.vehiclediary.R
import com.cool.element.vehiclediary.domain.Vehicle
import com.cool.element.vehiclediary.utils.Constants

@Composable
fun VehicleRow(
    vehicle: Vehicle,
    onClick: () -> Unit
) {
    Row(
        modifier = Modifier
            .fillMaxWidth()
            .padding(8.dp)
            .clickable {
                Log.d(
                    Constants.LogTag.debug,
                    "VehicleRow: ${vehicle.name} ${vehicle.uuid} clicked"
                )
                onClick()
            },
        verticalAlignment = Alignment.CenterVertically
    ) {
        AsyncImage(
            model = vehicle.image,
            contentDescription = null,
            placeholder = painterResource(R.drawable.outline_image_24),
            error = painterResource(R.drawable.outline_image_24),
            contentScale = ContentScale.Crop,
            modifier = Modifier
                .size(60.dp)
                .clip(CircleShape)
                .graphicsLayer {
                    alpha = 0.5f
                }
        )
        Spacer(modifier = Modifier.width(16.dp))
        Column {
            Text(text = vehicle.name, fontWeight = FontWeight.Bold, fontSize = 20.sp)
            Text(text = "${vehicle.brand} ${vehicle.model} (${vehicle.year})", color = Color.Gray)
            Text(text = "Odometer: ${vehicle.odometer} km", color = Color.Gray, fontSize = 12.sp)
        }
    }
}


@Preview(showBackground = true)
@Composable
fun VehicleRowPreview() {
    VehicleRow(
        vehicle = Vehicle.sample(),
        onClick = {}
    )
}