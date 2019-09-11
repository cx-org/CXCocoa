# CXCompatible([中文](README.zh_cn.md))

[![travis](https://img.shields.io/travis/cx-org/CXCompatible)](https://travis-ci.org/cx-org/CXCompatible)
[![release](https://img.shields.io/github/release-pre/cx-org/CXCompatible)](https://github.com/cx-org/CXCompatible/releases)
![install](https://img.shields.io/badge/install-spm%20%7C%20cocoapods%20%7C%20carthage-ff69b4)
![platform](https://img.shields.io/badge/platform-ios%20%7C%20macos%20%7C%20watchos%20%7C%20tvos%20%7C%20linux-lightgrey)
![license](https://img.shields.io/github/license/cx-org/CXCompatible?color=black)
[![dicord](https://img.shields.io/badge/chat-discord-9cf)](https://discord.gg/cresT3X)

CXCompatible provides compatibility shims for [CombineX](https://github.com/cx-org/CombineX). Using it, you can write code that is compatible with both Combine and CombineX. In other words, you can freely switch dependencies between Combine and CombineX without modifying the code base.

```swift
#if USE_COMBINE
import CXFoundation
#else
import CXCompatible
#endif

let task = Timer.cx.publish(every: 1, on: RunLoop.main, in: .default)
    .sink { date in
        // task
    }
```

`Combine` enables many system types to support `Publisher`, for example:

```swift
let nums = [0, 1, 2].publisher

let task = URLSession.share.dataTaskPublisher(for: endpoint)
```

## Why do I need CXCompatible

You should already know [`CombineX`](https://github.com/cx-org/CombineX), which is an open source implementation of Combine. Its purpose is to provide a completely consistent API with Combine, freeing you from the limitations of the version and platform. This sounds great, isn't it? But the implementation has encountered some trouble.

Combine directly extends some system types and provides them with a pub-sub interface, such as:

```swift
let nums = [0, 1, 2].publisher

let task = URLSession.share.dataTaskPublisher(for: endpoint)
```

CombineX tries to provide the same functionality, but unfortunately it can't use the same API, such as:

```swift
extension Sequence {
    // Error: ambiguous use of ...
    public var publisher: Publishers.Sequence {
        // ...
    }
}

extension URLSession {
    // Swift doesn't allow you to define the same name again, even in a different framework.
    public struct DataTaskPublisher: Publisher {
        // ...
    }
}
```

CombineX's solution is `cx`:

```swift
let nums = [1, 2, 3].cx.publisher

let task = URLSession.share.cx.dataTaskPublisher(for: endpoint)
```

Yes, this breaks the consistency of CombineX and Combine. To make this code compatible with Combine, CXCompatible implements an alternative implementation of all `cx` interfaces, but based on Combine.

## Install

### Swift Package Manager

```swift
dependencies.append(
    .package(url: "https://github.com/cx-org/CXCompatible", .branch("master"))
)
```

### CocoaPods

```ruby
pod 'CXCompatible', :git => 'https://github.com/cx-org/CXCompatible.git', :branch => 'master'
```

### Carthage

```carthage
github "cx-org/CXCompatible" "master"
```

## Related

- [CombineX](https://github.com/cx-org/CombineX)
- [CXFoundation](https://github.com/cx-org/CXFoundation)
- [CXExtensions](https://github.com/cx-org/CXExtensions)
- [CXCocoa](https://github.com/cx-org/CXCocoa)
