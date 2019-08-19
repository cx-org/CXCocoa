import Foundation

enum Global {
    
    static func MainThreadPrecondition(file: StaticString = #file, line: UInt = #line) {
        precondition(Thread.isMainThread, "not main thread", file: file, line: line)
    }
}
