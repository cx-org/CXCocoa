# CXCompatible([中文](README.zh_cn.md))

This library provides shims for all [`CombineX`](https://github.com/cx-org/CombineX) interface.

`Combine` enables many system types to support `Publisher`, for example:

```swift
let nums = [0, 1, 2].publisher

let task = URLSession.share.dataTaskPublisher(for: endpoint)
```

`CombineX` tries to provide the same functionality, but unfortunately, it can't use the same API. If the same interface is defined in the same location, Swift will fail to compile. such as:

```swift
extension URLSession {
    struct DataTaskPublisher: Publisher {
        // ...
    }
}
```

Thus, `CombineX` uses a workaround. You can do this with `cx`:

```swift
let nums = [1, 2, 3].cx.publisher

let task = URLSession.share.cx.dataTaskPublisher(for: endpoint)
```

To make this code compatible with `Combine`, this library provides alternative implementations of all `cx` interfaces, but based on `Combine`, no `CombineX` dependency.

You should only temporarily use this library when you want to remove `CombineX` from your project.

## Try it out

### Swift Package Manager

In your `Package.swift`:

```swift
dependencies.append(
    .package(url: "https://github.com/cx-org/CXCompatible", .branch("master"))
)
```
