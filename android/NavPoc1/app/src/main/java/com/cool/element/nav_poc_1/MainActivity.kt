package com.cool.element.nav_poc_1

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.Scaffold
import androidx.compose.ui.Modifier
import androidx.navigation.compose.rememberNavController
import com.cool.element.nav_poc_1.ui.theme.NavPoc1Theme

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContent {
            NavPoc1Theme {
                Scaffold(modifier = Modifier.fillMaxSize()) { innerPadding ->
                    AppNavigation(
                        viewModel = StubRecordsListViewModel(),
                        navController = rememberNavController(),
                        // TODO: INVESTIGATE: do we actually need this modifier injected at this level?
                        modifier = Modifier.padding(innerPadding)
                    )
                }
            }
        }
    }
}
