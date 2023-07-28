import Swinject
import SwinjectAutoregistration
import shared

final class AppAssembly {}

extension AppAssembly: Assembly {
    @MainActor
    func assemble(container: Container) {
        container.register(
            RuntimeSqlDriver.self,
            factory: { _ in
                DatabaseDriverFactory().createDriver()
            })
        
        container.register(
            NotesDatabase.self,
            factory: { resolver in
                let driver = resolver ~> RuntimeSqlDriver.self
                return NotesDatabaseFactory(driver: driver).createNotesDatabase()
            })
        
        container.autoregister(
            NoteDataSource.self,
            initializer: SqlDelightNoteDataSource.init
        )
        
        container.autoregister(
            SearchNoteUseCase.self,
            initializer: SearchNoteUseCase.init
        )
        
        container.autoregister(
            NoteListViewModel.self,
            initializer: NoteListViewModel.init
        )
        
        container.autoregister(
            NoteDetailViewModel.self,
            argument: Int64?.self,
            initializer: NoteDetailViewModel.init
        )
    }
}
