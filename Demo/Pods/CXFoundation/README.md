# CXFoundation([中文](README.zh_cn.md))

![build](https://img.shields.io/travis/cx-org/CXFoundation)
![release](https://img.shields.io/github/release-pre/cx-org/CXFoundation)
![install](https://img.shields.io/badge/install-spm%20%7C%20cocoapods%20%7C%20carthage-ff69b4)
![platform](https://img.shields.io/badge/platform-ios%20%7C%20macos%20%7C%20watchos%20%7C%20tvos%20%7C%20linux-lightgrey)
![license](https://img.shields.io/github/license/cx-org/CXFoundation?color=black)

`Combine + Foundation`, built on top of [CombineX](https://github.com/cx-org/CombineX).

- `DispatchQueue`
- `JSONDecoder`
- `JSONEncoder`
- `NotificationCenter`
- `OperationQueue`
- `PropertyListDecoder`
- `PropertylistEncoder`
- `RunLoop`
- `Timer`
- `URLSession`

## Notice

This library is still in beta, so **do not use it in production!**

🐱

## Living examples

### Timer

```swift
let ping = Timer.cx.publish(every: 1, on: RunLoop.main, in: .default)
    .sink { d in 
        // ping
    }
```

### URLSession

```swift
let request = URLSession.shared.cx.dataTaskPublisher(for: host)
    .sink { (data, response) in
        // update ui
    }
```

### NotificationCenter

```swift
let observe = NotificationCenter.default.cx.publisher(for: name)
    .sink { notification in
        // 
    }
```

### Scheduler

```swift
let cancel = upstream
    .receive(on: RunLoop.main.cx.scheduler)
    .sink { v in
        //
    }
```

## 安装

### Swift Package Manager

```swift
dependencies.append(
    .package(url: "https://github.com/cx-org/CXFoundation", .branch("master"))
)
```

### CocoaPods

```ruby
pod 'CxFoundation', :git => 'https://github.com/cx-org/CXFoundation.git', :branch => 'master'
```

### Carthage

```carthage
github "cx-org/CXFoundation" "master"
```

## Related

- [CombineX](https://github.com/cx-org/CombineX)
- [CXCocoa](https://github.com/cx-org/CXCocoa)
- [CXCompatible](https://github.com/cx-org/CXCompatible)

## FAQ

#### Why not use Combine directly？

See [here](https://github.com/cx-org/CombineX#why-write-this).

#### Why are the interfaces not exactly the same as Combine?

`Combine` directly extends the system type. We can't define the same interface in the same place - it won't compile. Such as:

```swift
extension URLSession {
    struct DataTaskPublisher: Publisher {
        // ...
    }
}
```

#### If the interfaces are inconsistent, will migration be very troublesome?

[CXCompatible](https://github.com/cx-org/CXCompatible)  provides implementations of all `cx` interfaces, but based on `Combine`, no `CombineX` dependency. It can help you migrate painlessly.
