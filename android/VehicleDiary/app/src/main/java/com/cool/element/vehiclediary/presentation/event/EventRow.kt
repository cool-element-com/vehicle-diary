package com.cool.element.vehiclediary.presentation.event

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