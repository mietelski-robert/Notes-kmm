import SwiftUI

struct NoteSearchBar: View {
    @Binding var searchText: String
    let closeAction: () -> Void
    
    var body: some View {
        HStack {
            TextField("Search...", text: $searchText)
                .textFieldStyle(.roundedBorder)
            
            Button(action: closeAction) {
                Image(systemName: "xmark")
            }
        }
    }
}

struct NoteSearchBar_Previews: PreviewProvider {
    static var previews: some View {
        NoteSearchBar(
            searchText: .constant("Adam"),
            closeAction: {}
        )
    }
}
