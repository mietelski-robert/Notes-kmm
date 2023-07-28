package pl.mietelski.robert.notesapp.android

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.navigation.NavType
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import androidx.navigation.navArgument
import dagger.hilt.android.AndroidEntryPoint
import pl.mietelski.robert.notesapp.android.noteDetail.NoteDetailScreen
import pl.mietelski.robert.notesapp.android.noteList.NoteListScreen

@AndroidEntryPoint
class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            val navController = rememberNavController()

            NavHost(navController = navController, startDestination = "noteList") {
                composable(route = "noteList") {
                    NoteListScreen(navController = navController)
                }
                composable(
                    route = "noteDetail/{noteId}",
                    arguments = listOf(
                        navArgument(name = "noteId") {
                            type = NavType.LongType
                            defaultValue = -1L
                        }
                    )
                ) { backStackEntry ->
                    val noteId = backStackEntry.arguments?.getLong("noteId") ?: -1L
                    NoteDetailScreen(
                        noteId = noteId,
                        navController = navController
                    )
                }
            }

        }
    }
}