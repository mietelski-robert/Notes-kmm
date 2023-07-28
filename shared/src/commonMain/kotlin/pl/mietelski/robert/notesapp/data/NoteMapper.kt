package pl.mietelski.robert.notesapp.data

import databse.NoteEntity
import kotlinx.datetime.*
import pl.mietelski.robert.notesapp.domain.note.Note

fun NoteEntity.toNote(): Note {
    return  Note(
        id = id,
        title = title,
        content = content,
        colorHex = colorHex,
        created = Instant
            .fromEpochMilliseconds(created)
            .toLocalDateTime(TimeZone.currentSystemDefault())
    )
}