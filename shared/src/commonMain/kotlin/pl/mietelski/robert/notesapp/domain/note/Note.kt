package pl.mietelski.robert.notesapp.domain.note

import kotlinx.datetime.LocalDateTime
import pl.mietelski.robert.notesapp.presentation.*

data class Note(
    val id: Long?,
    val title: String,
    val content: String,
    val colorHex: Long,
    val created: LocalDateTime
) {
    companion object {
        private val colors = listOf(RedOrangeHex, RedPinkHex, BabyBlueHex, VioletHex, LightGreenHex)

        fun generateRandomColor() = colors.random()
    }
}
