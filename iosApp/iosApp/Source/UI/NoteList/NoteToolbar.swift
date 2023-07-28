import SwiftUI

struct NoteToolbar: View {
    @Binding var isSearchActive: Bool
    
    var body: some View {
        HStack {
            Text("All Notes")
                .font(.title2)
            Spacer()
            Button(action: {
                isSearchActive.toggle()
            }) {
                Image(systemName: "magnifyingglass")
            }
        }
    }
}

struct NoteToolbar_Previews: PreviewProvider {
    static var previews: some View {
        NoteToolbar(isSearchActive: .constant(false))
    }
}
