package pl.mietelski.robert.notesapp.domain.note

import pl.mietelski.robert.notesapp.domain.time.DateTimeUtil

class SearchNoteUseCase {
    fun execute(notes: List<Note>, query: String): List<Note> {
        if (query.isBlank()) {
            return notes
        }
        return notes.filter {
            it.title.trim().lowercase().contains(query.lowercase()) ||
                    it.content.trim().lowercase().contains(query.lowercase())
            }
            .sortedBy {
                DateTimeUtil.toEpochMillis(it.created)
            }
    }
}