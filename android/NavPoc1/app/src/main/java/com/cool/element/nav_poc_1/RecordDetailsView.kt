package com.cool.element.nav_poc_1

import androidx.compose.foundation.border
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.navigation.NavController
import androidx.navigation.NavHostController

@Composable
fun RecordDetailsView(
    viewModel: RecordDetailsViewModel,
    /// TODO: INVESTIGATE: do we need to pass a reference to the navHostController if we are not going to navigate further inwards?
    navController: NavController,
    modifier: Modifier = Modifier
) {
    Column(
        horizontalAlignment = Alignment.Start,
        modifier = modifier
            .padding(vertical = 64.dp)
            .padding(horizontal = 16.dp)
    ) {
        RecordDetailsHeader(
            viewModel = viewModel,
            modifier = modifier
        )
        RecordDetailsBody(
            viewModel = viewModel,
            modifier = Modifier
        )
    }
}

@Composable
fun RecordDetailsHeader(
    viewModel: RecordDetailsViewModel,
    modifier: Modifier
) {
    Text(
        text = viewModel.record().title,
        fontSize = 24.sp,
        fontWeight = FontWeight.SemiBold,
        color = MaterialTheme.colorScheme.primary,
        modifier = modifier
    )
}

@Composable
fun RecordDetailsBody(
    viewModel: RecordDetailsViewModel,
    modifier: Modifier
) {
    Text(
        text = viewModel.record().description,
        fontWeight = FontWeight.Normal,
        color = MaterialTheme.colorScheme.secondary,
        modifier = modifier

    )
}

@Preview(showBackground = true)

@Composable
fun RecordDetailsViewPreview() {
    Box(
        modifier = Modifier
            .size(
                width = 1080.dp,
                height = 1920.dp
            )
    ) {
        RecordDetailsView(
            viewModel = StubRecordDetailsViewModel(
                recordId = DemoRecord.sample.id
            ),
            navController = NavController(LocalContext.current)
        )
    }
}