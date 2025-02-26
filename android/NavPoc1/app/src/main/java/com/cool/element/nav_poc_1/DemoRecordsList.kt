package com.cool.element.nav_poc_1

import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.offset
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.navigation.NavController

@Composable
fun DemoRecordsList(
    records: List<DemoRecord>,
    navController: NavController,
    modifier: Modifier = Modifier
) {
    LazyColumn(
        modifier = modifier
            .fillMaxSize()
            .padding(16.dp)
            .offset(y = 48.dp)
    ) {
        items(records) { record ->
            SampleRow(
                record = record,
                onClick = {
                    navController
                        .navigate(
                            route = Screen.RecordDetailsScreen.route + "/${record.id}"
                        )
                }
            )
        }
    }
}

@Preview(showBackground = true)
@Composable
fun PreviewDemoRecordsList() {
    DemoRecordsList(
        records = DemoRecord.sampleList,
        navController = NavController(LocalContext.current)
    )
}

// Application Screens
sealed class Screen(val route: String) {
    object RecordListScreen : Screen("record_list_screen")
    object RecordDetailsScreen : Screen("record_details_screen")
}