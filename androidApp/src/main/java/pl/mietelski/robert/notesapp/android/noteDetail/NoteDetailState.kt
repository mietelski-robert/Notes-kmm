package pl.mietelski.robert.notesapp.android.noteDetail

data class NoteDetailState(
    val noteTile: String = "",
    val isNoteTitleHintVisible: Boolean = false,
    val noteContent: String = "",
    val isNoteContentHintVisible: Boolean = false,
    val noteColor: Long = 0xFFFFFF
) {

}
