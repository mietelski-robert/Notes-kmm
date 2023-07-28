import SwiftUI
import shared

struct NoteItemView: View {
    let note: Note
    let deleteAction: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(note.title)
                    .font(.title3)
                    .fontWeight(.semibold)
                Spacer()
                Button(action: deleteAction) {
                    Image(systemName: "xmark")
                }
            }
            .padding(.bottom, 5.0)
            
            Text(note.content)
                .fontWeight(.light)
                .padding(.bottom, 5.0)
            
            HStack {
                Spacer()
                Text(DateTimeUtil().formatNoteDate(dateTime: note.created))
                    .font(.footnote)
                    .fontWeight(.light)
            }
        }
        .padding()
        .background(Color(hex: note.colorHex))
        .clipShape(RoundedRectangle(cornerRadius: 5.0))
    }
}

struct NoteItemView_Previews: PreviewProvider {
    static var previews: some View {
        NoteItemView(
            note: mock.note,
            deleteAction: {}
        )
    }
}
