package pl.mietelski.robert.notesapp.data

import pl.mietelski.robert.notesapp.databse.NotesDatabase
import pl.mietelski.robert.notesapp.domain.note.*
import pl.mietelski.robert.notesapp.domain.time.DateTimeUtil

class SqlDelightNoteDataSource(db: NotesDatabase): NoteDataSource {
    private val queries = db.notesQueries

    override suspend fun insertNote(note: Note) {
        queries.insertNote(
            id = note.id,
            title = note.title,
            content = note.content,
            colorHex = note.colorHex,
            created = DateTimeUtil.toEpochMillis(note.created)
        )
    }

    override suspend fun getNoteById(id: Long): Note? {
        return queries.getNoteById(id)
            .executeAsOneOrNull()
            ?.toNote()
    }

    override suspend fun getAllNotes(): List<Note> {
        return queries
            .getAllNotes()
            .executeAsList()
            .map { it.toNote() }
    }

    override suspend fun deleteNoteById(id: Long) {
        queries.deleteNoteById(id)
    }
}