import Foundation
import shared

@MainActor
final class NoteListViewModel {
    
    @Published private(set) var notes: [Note] = []
    @Published private(set) var error: NoteListError?
    @Published var isErrorPresented: Bool = false
    
    @Published var searchText: String = "" {
        didSet {
            notes = searchNotesUseCase.execute(
                notes: allNotes,
                query: searchText
            )
        }
    }
    @Published var isSearchActive: Bool = false {
        didSet {
            guard !isSearchActive else { return }
            searchText = ""
        }
    }
    private var allNotes: [Note] = [] {
        didSet {
            notes = searchNotesUseCase.execute(
                notes: allNotes,
                query: searchText
            )
        }
    }
    private let noteDataSource: NoteDataSource
    private let searchNotesUseCase: SearchNoteUseCase
    
    init(
        noteDataSource: NoteDataSource,
        searchNotesUseCase: SearchNoteUseCase
    ) {
        self.noteDataSource = noteDataSource
        self.searchNotesUseCase = searchNotesUseCase
    }
    
    func loadNotes() async {
        do {
            self.allNotes = try await noteDataSource
                .getAllNotes()
                .sorted(by: { $0.created.compareTo(other: $1.created) > 0 })
        } catch {
            showError(NoteListError.loadNotesFailed(error))
        }
    }
    
    func deleteNote(_ note: Note) {
        guard let noteId = note.id?.int64Value else { return }
        
        Task {
            do {
                try await noteDataSource.deleteNoteById(id: noteId)
                await loadNotes()
            } catch {
                showError(NoteListError.deleteNoteFailed(error))
            }
        }
    }
    
    private func showError(_ error: NoteListError) {
        self.error = error
        self.isErrorPresented = true
    }
}

extension NoteListViewModel: ObservableObject {}
