import Foundation

extension DispatchQueue {
    
    static var isMainQueue: Bool {
        enum Once {
            static let key: DispatchSpecificKey<Void> = {
                let k = DispatchSpecificKey<Void>()
                DispatchQueue.main.setSpecific(key: k, value: ())
                return k
            }()
        }
        return DispatchQueue.getSpecific(key: Once.key) != nil
    }
}
