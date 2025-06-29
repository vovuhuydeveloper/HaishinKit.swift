import Foundation

/// An actor that provides a
///
/// ## Prerequisites
/// You need to register the factory in advance as follows.
/// ```
/// await SessionBuilderFactory.shared.register(RTMPSessionFactory())
/// await SessionBuilderFactory.shared.register(SRTSessionFactory())
/// ```
public actor SessionBuilderFactory {
    /// The shared instance.
    public static let shared = SessionBuilderFactory()

    private var factories: [any SessionFactory] = []

    private init() {
    }

    public func make(_ uri: URL?) -> SessionBuilder? {
        guard let uri else {
            return nil
        }
        return SessionBuilder(manager: self, uri: uri)
    }

    /// Registers a factory.
    public func register(_ factory: some SessionFactory) {
        factories.append(factory)
    }

    func build(_ uri: URL?) -> (any Session)? {
        guard let uri else {
            return nil
        }
        for factory in factories where factory.supportedProtocols.contains(uri.scheme ?? "") {
            return factory.make(uri: uri)
        }
        return nil
    }
}
