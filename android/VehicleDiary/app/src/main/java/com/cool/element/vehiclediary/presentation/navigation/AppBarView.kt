package com.cool.element.vehiclediary.presentation.navigation

import android.util.Log
import androidx.compose.foundation.layout.heightIn
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Text
import androidx.compose.material3.TopAppBar
import androidx.compose.material3.TopAppBarColors
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.res.colorResource
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.FontStyle
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.navigation.NavController
import com.cool.element.vehiclediary.R
import com.cool.element.vehiclediary.presentation.screens.vehiclesList.FakeVehiclesListViewModelImpl
import com.cool.element.vehiclediary.presentation.screens.vehiclesList.VehicleListView
import com.cool.element.vehiclediary.utils.Constants


@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun AppBarView(
    title: String,
    onBackButtonTapped: () -> Unit = {
        Log.d(
            Constants.LogTag.debug,
            "Back button tapped"
        )
    }
) {
    TopAppBar(
        title = {
            Text(
                text = title,
                style = TextStyle.Default.copy(
                    fontStyle = FontStyle.Normal,
                    fontSize = 24.sp
                ),
                modifier = Modifier
                    .padding(start = 4.dp)
                    .heightIn(max = 24.dp)
            )
        },
        colors = TopAppBarColors(
            containerColor = colorResource(id = R.color.app_color_3),
            scrolledContainerColor = colorResource(id = R.color.white),
            navigationIconContentColor = colorResource(id = R.color.white),
            titleContentColor = colorResource(id = R.color.app_color_1),
            actionIconContentColor = colorResource(id = R.color.white)
        )
//        backgroundColor = colorResource(id = R.color.app_bar_color),
//        navigationIcon = navIconButton(title, onBackButtonTapped)
    )
}

//fun navIconButton(
//    title: String,
//    action: () -> Unit
//) : (@Composable () -> Unit)? {
//    if (title.contains(Constants.ViewTitle.home)) {
//        return null
//    } else {
//        return { NavigationIcon(action = action) }
//    }
//}

//@Composable
//fun NavigationIcon(action: () -> Unit) {
//    IconButton(onClick = action) {
//        Icon(
//            imageVector = Icons.AutoMirrored.Filled.ArrowBack,
//            tint = colorResource(id = R.color.white),
//            contentDescription = null
//        )
//    }
//}

@Preview(showBackground = true)
@Composable
fun PreviewAppBarView() {
    VehicleListView(
        viewModel = FakeVehiclesListViewModelImpl(),
        navController = NavController(LocalContext.current)
    )
}