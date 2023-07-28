import SwiftUI

struct NoteListView: View {
    @StateObject var viewModel: NoteListViewModel
    
    init() {
        let wrappedValue = DIManager.resolve(NoteListViewModel.self)
        _viewModel = StateObject(wrappedValue: wrappedValue)
    }
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.notes, id: \.id) { note in
                    NavigationLink(value: note.id?.int64Value) {
                        NoteItemView(
                            note: note,
                            deleteAction: {
                                viewModel.deleteNote(note)
                            }
                        )
                    }
                }
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(for: Int64.self, destination: NoteDetailView.init)
        .toolbar {
            navigationBar
        }
        .task {
            await viewModel.loadNotes()
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
    
    @ToolbarContentBuilder
    var navigationBar: some ToolbarContent {
        ToolbarItem(placement: .principal) {
            ZStack {
                NoteSearchBar(
                    searchText: $viewModel.searchText) {
                        viewModel.isSearchActive.toggle()
                    }
                    .opacity(viewModel.isSearchActive ? 1.0 : 0.0)
                
                NoteToolbar(isSearchActive: $viewModel.isSearchActive)
                    .opacity(viewModel.isSearchActive ? 0.0 : 1.0)
            }
            .animation(.easeInOut, value: viewModel.isSearchActive)
        }
        
        ToolbarItem(placement: .navigationBarTrailing) {
            HStack {
                NavigationLink(destination: NoteDetailView(noteId: nil)) {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

struct NoteListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            NoteListView()
        }
    }
}
