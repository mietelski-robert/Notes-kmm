package pl.mietelski.robert.notesapp.data.local

import android.content.Context
import com.squareup.sqldelight.android.AndroidSqliteDriver
import com.squareup.sqldelight.db.SqlDriver
import pl.mietelski.robert.notesapp.databse.NotesDatabase

actual class DatabaseDriverFactory(private val context: Context) {
    actual fun createDriver(): SqlDriver {
        return  AndroidSqliteDriver(NotesDatabase.Schema, context, "notes.db")
    }
}