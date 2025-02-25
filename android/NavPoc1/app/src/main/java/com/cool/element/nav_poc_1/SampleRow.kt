package com.cool.element.nav_poc_1

import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import java.util.logging.Logger

@Composable
fun SampleRow(
    record: DemoRecord,
    onClick: () -> Unit = {
        Logger.getLogger("SampleRow").info("SampleRow clicked - NOT IMPLEMENTED")
    }
) {
    Row(
        modifier = Modifier
            .fillMaxWidth()
            .padding(8.dp)
            .clickable {
                onClick()
                Logger.getLogger("SampleRow").info("SampleRow clicked")
            },
        verticalAlignment = Alignment.CenterVertically
    ) {
        Column(
            modifier = Modifier
                .weight(1f)
                .padding(8.dp)
        ) {
            Text(
                text = record.title,
                fontSize = 16.sp,
                fontWeight = FontWeight.Bold,
                color = Color.Black
            )
            Text(
                text = record.description,
                fontSize = 14.sp,
                color = Color.Gray
            )
        }
    }
}

@Preview(showBackground = true)
@Composable
fun SampleRowPreview() {
    SampleRow(record = DemoRecord(title = "Sample Title"))
}