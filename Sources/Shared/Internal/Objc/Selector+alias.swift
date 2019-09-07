import Foundation

extension Selector {
    
    /// `self` as a pointer. It is uniqued across instances, similar to
    /// `StaticString`.
    var utf8Start: UnsafePointer<Int8> {
        return unsafeBitCast(self, to: UnsafePointer<Int8>.self)
    }

    /// An alias of `self`, used in method interception.
    var alias: Selector {
        return prefixed(with: "_cx_0_")
    }

    /// An alias of `self`, used in method interception specifically for
    /// preserving (if found) an immediate implementation of `self` in the
    /// runtime subclass.
    var interopAlias: Selector {
        return prefixed(with: "_cx_1_")
    }

    /// An alias of `self`, used for delegate proxies.
    var delegateProxyAlias: Selector {
        return prefixed(with: "_cx_2_")
    }

    private func prefixed(with prefix: StaticString) -> Selector {
        let length = Int(strlen(utf8Start))
        let prefixedLength = length + prefix.utf8CodeUnitCount

        let prefixedStart = UnsafeRawPointer(prefix.utf8Start).assumingMemoryBound(to: Int8.self)

        let name = UnsafeMutablePointer<Int8>.allocate(capacity: prefixedLength + 1)
        defer {
            name.deinitialize(count: prefixedLength + 1)
            name.deallocate()
        }

        name.initialize(from: prefixedStart, count: prefix.utf8CodeUnitCount)
        (name + prefix.utf8CodeUnitCount).initialize(from: self.utf8Start, count: length)
        (name + prefixedLength).initialize(to: Int8(UInt8(ascii: "\0")))

        return sel_registerName(name)
    }
}
