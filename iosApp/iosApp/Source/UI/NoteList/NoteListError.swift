import Foundation

enum NoteListError: LocalizedError {
    case loadNotesFailed(Error)
    case deleteNoteFailed(Error)
    
    var errorDescription: String? {
        switch self {
        case .loadNotesFailed:
            return "Loading notes error"
        case .deleteNoteFailed:
            return "Deleting note error"
        }
    }
    
    var errorMessage: String {
        switch self {
        case .loadNotesFailed(let error), .deleteNoteFailed(let error):
            return error.localizedDescription
        }
    }
}
