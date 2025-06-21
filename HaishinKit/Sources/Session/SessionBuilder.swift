import Foundation

public struct SessionBuilder: Sendable {
    let manager: SessionBuilderFactory
    let uri: URL

    init(manager: SessionBuilderFactory, uri: URL) {
        self.manager = manager
        self.uri = uri
    }

    public func build() async -> (any Session)? {
        return await manager.build(uri)
    }
}
