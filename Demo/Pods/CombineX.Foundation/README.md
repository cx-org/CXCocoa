# CombineX.Foundation([中文](README.zh_cn.md))

<img src="https://img.shields.io/travis/CombineXCommunity/CombineX.Foundation">

This library provides an alternative implementation of `Combine + Foundation`, built on top of [CombineX](https://github.com/luoxiu/CombineX).

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

## Status

Compatible with Combine beta 5.

## Notice

This library is still in the test stage, **Please do not use it in production!**

🐱

## Example

#### Timer

```swift
let schedule = Timer.cx.publish(every: 1, on: RunLoop.main, in: .default)
```

#### URLSession

```swift
let ping = URLSession.shared.cx.dataTaskPublisher(for: host)
```

#### NotificationCenter

```swift
let event = NotificationCenter.default.cx.publisher(for: name)
```

#### Scheduler

```swift
let cancel = upstream
    .subscribe(on: workQueue.rx.scheduler)
    .receive(on: RunLoop.main.rx.scheduler)
    .sink { v in
    }
```

## Try it out

#### Swift Package Manager

In your `Package.swift`:

```swift
pkg.dependencies.append(
    .package(url: "https://github.com/CombineXCommunity/CombineX.Foundation", ._branchItem("master"))
)
```

## Related

- [CombineX](https://github.com/luoxiu/CombineX)
- [CombineX.Compatible](https://github.com/CombineXCommunity/CombineX.Compatible)

## More

#### Why not use Combine directly？

See [here](https://github.com/luoxiu/CombineX#why-write-this)。

#### Why are the interfaces inconsistent with Combine?

`Combine` directly extends the system type. If the same statement is defined in the same location again, Swift will fail to compile. For example:

```swift
extension URLSession {
    struct DataTaskPublisher: Publisher {
        // ...
    }
}
```

#### If the interfaces are inconsistent, will migration be very troublesome?

[CombineX.Compatible](https://github.com/CombineXCommunity/CombineX.Compatible) provides implementations of all `cx` interfaces, but based on `Combine`, no `CombineX` dependency. It can help you migrate painlessly.
