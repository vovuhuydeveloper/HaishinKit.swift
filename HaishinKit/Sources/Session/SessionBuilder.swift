import Foundation

public struct SessionBuilder: Sendable {
    let manager: SessionBuilderFactory
    let uri: URL

    public func build() async -> (any Session)? {
        return await manager.build(uri)
    }
}
