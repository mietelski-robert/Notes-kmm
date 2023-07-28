package pl.mietelski.robert.notesapp.android.noteList

import pl.mietelski.robert.notesapp.domain.note.*

data class NoteListState(
    val notes: List<Note> = emptyList(),
    val searchText: String = "",
    val isSearchActive: Boolean = false
)
