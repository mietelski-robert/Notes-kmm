package pl.mietelski.robert.notesapp.android.di

import android.app.Application
import com.squareup.sqldelight.db.SqlDriver
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.components.SingletonComponent
import pl.mietelski.robert.notesapp.data.SqlDelightNoteDataSource
import pl.mietelski.robert.notesapp.data.local.DatabaseDriverFactory
import pl.mietelski.robert.notesapp.databse.NotesDatabase
import pl.mietelski.robert.notesapp.domain.note.NoteDataSource
import pl.mietelski.robert.notesapp.domain.note.NotesDatabaseFactory
import javax.inject.Singleton

@Module
@InstallIn(SingletonComponent::class)
object AppModule {

    @Provides
    @Singleton
    fun provideDriver(app: Application): SqlDriver {
        return DatabaseDriverFactory(app).createDriver()
    }

    @Provides
    @Singleton
    fun provideNotesDatabase(driver: SqlDriver): NotesDatabase {
        return NotesDatabaseFactory(driver).createNotesDatabase()
    }

    @Provides
    @Singleton
    fun provideNoteDataSource(notesDatabase: NotesDatabase): NoteDataSource {
        return SqlDelightNoteDataSource(notesDatabase)
    }
}