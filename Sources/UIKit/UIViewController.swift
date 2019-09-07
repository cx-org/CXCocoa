import UIKit

extension CombineXBox where Base: UIViewController {
    
    public var title: UIBinder<String?> {
        return UIBinder(target: self.base) { $0.title = $1 }
    }
    
    public var viewWillAppear: AnyPublisher<Void, Never> {
        return self.methodInvoked(for: #selector(Base.viewWillAppear))
    }
    
    public var viewDidAppear: AnyPublisher<Void, Never> {
        return self.methodInvoked(for: #selector(Base.viewDidAppear))
    }
    
    public var viewWillDisappear: AnyPublisher<Void, Never> {
        return self.methodInvoked(for: #selector(Base.viewWillDisappear))
    }
    
    public var viewDidDisappear: AnyPublisher<Void, Never> {
        return self.methodInvoked(for: #selector(Base.viewDidDisappear))
    }
    
    public var viewWillLayoutSubviews: AnyPublisher<Void, Never> {
        return self.methodInvoked(for: #selector(Base.viewWillLayoutSubviews))
    }
    
    public var viewDidLayoutSubviews: AnyPublisher<Void, Never> {
        return self.methodInvoked(for: #selector(Base.viewDidLayoutSubviews))
    }
}
