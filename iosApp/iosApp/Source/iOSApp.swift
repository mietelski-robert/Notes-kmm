import SwiftUI

@main
struct iOSApp {
    init() {
        DIManager.initialize(
            AppAssembly()
        )
    }
}

// MARK: - App implementation

extension iOSApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                NoteListView()
            }
        }
    }
}
