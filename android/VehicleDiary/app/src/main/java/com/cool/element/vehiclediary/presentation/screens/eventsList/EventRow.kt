package com.cool.element.vehiclediary.presentation.screens.eventsList

import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.cool.element.vehiclediary.domain.VEvent
import java.time.format.DateTimeFormatter

@Composable
fun EventRow(event: VEvent) {
    Column(
        modifier = Modifier
            .fillMaxWidth()
            .padding(8.dp)
    ) {
        Text(text = event.title, fontWeight = FontWeight.Bold, fontSize = 16.sp)
        Text(text = "Location: ${event.location}", fontSize = 14.sp)
        Text(text = "Recorded Date: ${event.recordedDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"))}", fontSize = 12.sp, color = Color.Gray)
        if (event.isCompleted == true) {
            Text(text = "Completed", color = Color.Green, fontSize = 12.sp)
        } else {
            Text(text = "Upcoming: ${event.upcomingDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"))}", fontSize = 12.sp, color = Color.Red)
        }
    }
}
@Preview(showBackground = true)
@Composable
fun EventRowPreview() {
    val event = VEvent.sample
    EventRow(
        event = event
    )
}
