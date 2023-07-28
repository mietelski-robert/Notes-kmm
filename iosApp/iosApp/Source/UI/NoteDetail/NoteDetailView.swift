import SwiftUI
import shared

struct NoteDetailView: View {
    @StateObject var viewModel: NoteDetailViewModel
    @Environment(\.dismiss) var dismissAction
    
    init(noteId: Int64?) {
        let wrappedValue = DIManager.resolve(
            NoteDetailViewModel.self,
            argument: noteId
        )
        _viewModel = StateObject(wrappedValue: wrappedValue)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                TextField(
                    "Enter a title...",
                    text: $viewModel.noteTtitle
                )
                TextField(
                    "Enter some content...",
                    text: $viewModel.noteContent
                )
            }
            .padding()
        }
        .background(Color(hex: viewModel.noteColor))
        .task { await viewModel.loadNote() }
        .navigationTitle("Note detail")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    viewModel.saveNote()
                }) {
                    Image(systemName: "checkmark")
                }
                .onReceive(viewModel.$isSaved) { isSaved in
                    guard isSaved else { return }
                    dismissAction()
                }
            }
        }
        .alert(
            isPresented: $viewModel.isErrorPresented,
            error: viewModel.error,
            actions: { _ in
                Button(role: .cancel, action: {}) {
                    Text("Close")
                }
            }, message: { error in
                Text(error.errorMessage)
            })
    }
}

struct NoteDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            NoteDetailView(noteId: nil)
        }
    }
}
