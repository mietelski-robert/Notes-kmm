import Foundation
import shared

@MainActor
final class NoteDetailViewModel: ObservableObject {
    
    @Published var noteTtitle: String = ""
    @Published var noteContent: String = ""
    @Published private(set) var noteColor: Int64 = Note.Companion().generateRandomColor()
    @Published private(set) var error: NoteDetailError?
    @Published var isErrorPresented: Bool = false
    @Published private(set) var isSaved: Bool = false
    
    private let noteId: Int64?
    private let noteDataSource: NoteDataSource
    
    init(
        noteId: Int64?,
        noteDataSource: NoteDataSource
    ) {
        self.noteId = noteId
        self.noteDataSource = noteDataSource
    }
    
    func loadNote() async {
        do {
            guard let noteId, let note = try await noteDataSource.getNoteById(id: noteId) else {
                return
            }
            self.noteTtitle = note.title
            self.noteContent = note.content
            self.noteColor = note.colorHex
        } catch {
            showError(NoteDetailError.loadNoteFailed(error))
        }
    }
    
    func saveNote() {
        Task {
            do {
                let id: KotlinLong?
                
                if let noteId {
                    id = KotlinLong(longLong: noteId)
                } else {
                    id = nil
                }
                try await noteDataSource.insertNote(
                    note: Note(
                        id: id,
                        title: noteTtitle,
                        content: noteContent,
                        colorHex: noteColor,
                        created: DateTimeUtil().now()
                    )
                )
                isSaved = true
            } catch {
                showError(NoteDetailError.saveNoteFailed(error))
            }
        }
    }
    
    private func showError(_ error: NoteDetailError) {
        self.error = error
        self.isErrorPresented = true
    }
}
