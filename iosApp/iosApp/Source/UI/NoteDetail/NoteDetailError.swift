import Foundation

enum NoteDetailError: LocalizedError {
    case loadNoteFailed(Error)
    case saveNoteFailed(Error)
    
    var errorDescription: String? {
        switch self {
        case .loadNoteFailed:
            return "Loading note error"
        case .saveNoteFailed:
            return "Saving note error"
        }
    }
    
    var errorMessage: String {
        switch self {
        case .loadNoteFailed(let error), .saveNoteFailed(let error):
            return error.localizedDescription
        }
    }
}
