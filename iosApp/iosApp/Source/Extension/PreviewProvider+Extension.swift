import SwiftUI
import shared

extension PreviewProvider {
    static var mock: DeveloperMockContract {
        DeveloperMock.shared
    }
}

protocol DeveloperMockContract {
    var note: Note { get }
}

fileprivate final class DeveloperMock: DeveloperMockContract {
    let note = Note(
        id: nil,
        title: "Note title",
        content: "Note Content",
        colorHex: 0xffcf94da,
        created: DateTimeUtil().now()
    )
    static let shared = DeveloperMock()
    
    private init() {}
}
