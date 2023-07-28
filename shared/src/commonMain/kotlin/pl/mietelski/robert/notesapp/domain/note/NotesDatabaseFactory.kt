package pl.mietelski.robert.notesapp.domain.note

import com.squareup.sqldelight.db.SqlDriver
import pl.mietelski.robert.notesapp.databse.NotesDatabase

class NotesDatabaseFactory(
    private val driver: SqlDriver
) {
    fun createNotesDatabase(): NotesDatabase {
        return NotesDatabase(driver)
    }
}