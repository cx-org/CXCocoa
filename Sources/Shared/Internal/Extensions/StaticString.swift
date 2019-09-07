extension StaticString {
    
    var cPointer: UnsafePointer<Int8> {
        return UnsafeRawPointer(self.utf8Start).assumingMemoryBound(to: Int8.self)
    }
    
    static func cPointer(to str: StaticString) -> UnsafePointer<Int8> {
        return str.cPointer
    }
}
