package pl.mietelski.robert.notesapp.data.local

import com.squareup.sqldelight.db.SqlDriver
import com.squareup.sqldelight.drivers.native.NativeSqliteDriver
import pl.mietelski.robert.notesapp.databse.NotesDatabase

actual class DatabaseDriverFactory {
     actual fun createDriver(): SqlDriver {
         return NativeSqliteDriver(NotesDatabase.Schema, "notes.db")
     }
}