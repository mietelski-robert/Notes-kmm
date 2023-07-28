import Swinject
import SwinjectAutoregistration

final class DIManager {
    static var assembler: Assembler!

    static func initialize(_ assemblies: [Assembly]) {
        assembler = Assembler(assemblies)
    }

    static func initialize(_ assemblies: Assembly...) {
        assembler = Assembler(assemblies)
    }
    
    static func resolve<Service>(
        _: Service.Type,
        name: String? = nil
    ) -> Service {
        assembler.resolver.resolve(Service.self, name: name)!
    }

    static func resolve<Service, Arg1>(
        _: Service.Type,
        name: String? = nil,
        argument: Arg1
    ) -> Service {
        assembler.resolver.resolve(Service.self, name: name, argument: argument)!
    }
    
    static func resolve<Service, Arg1, Arg2>(
        _: Service.Type,
        name: String? = nil,
        argument1: Arg1,
        argument2: Arg2
    ) -> Service {
        assembler.resolver.resolve(Service.self, name: name, arguments: argument1, argument2)!
    }
    
    static func resolve<Service, Arg1, Arg2, Arg3>(
        _: Service.Type,
        name: String? = nil,
        argument1: Arg1,
        argument2: Arg2,
        argument3: Arg3
    ) -> Service {
        assembler.resolver.resolve(Service.self, name: name, arguments: argument1, argument2, argument3)!
    }
}
