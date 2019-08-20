# CombineX.Cocoa

![GitHub release (latest by date including pre-releases)](https://img.shields.io/github/v/release/luoxiu/combinex.cocoa?include_prereleases)
![swift](https://img.shields.io/badge/swift-5.0-orange)
![platform](https://img.shields.io/badge/platform-ios%20%7C%20macos%20%7C%20watchos%20%7C%20tvos-lightgrey)

## Notice

本库仍在 beta 测试，所以，**还不可以把它用在生产项目中！**

🐱

## 什么是 CombineX.Cocoa

与 ReactiveCocoa 和 ReaciveSwift, RxCocoa 和 RxSwift 的关系一样，CombineX.Cocoa 是 [CombineX.swift](https://github.com/luoxiu/CombineX) 的衍生库。它为 Cocoa Framework 框架提供了 [Combine](https://developer.apple.com/documentation/combine) 扩展，让你可以用 Combine 兼容的优雅语法书写 Cocoa 相关的异步代码。

它包括：

- KVOPublisher，通过 KVO 机制观察属性变化
- MethodPublisher/DeallocatePublisher，通过 Method Swizzle 拦截方法调用
- UIKit binder&property，订阅控件事件，绑定值
- Delegate proxy
- UIScheduler
- ... 

这一切都基于 [CombineX](https://github.com/luoxiu/CombineX) 实现。**在 Combine 正式发布后，你可以自由地切换底层支援。**

## Demo

<p align="center">
<img src="demo.gif">
</p>

```swift
let langPub = langSeg.cx.selectedSegmentIndex
    .map {
        ["swift", "javascript", "go"][$0]
    }

isOnSwitch.cx.isOn
    .compactMap {
        $0 ? nil : ""
    }
    .bind(to: self.logTextView.cx.text)
    .cancel(by: self)

keywordTextField.cx.text
    .throttle(for: .seconds(0.1), scheduler: UIScheduler.shared, latest: true)
    .combineLatest(langPub, isOnSwitch.cx.isOn)
    .compactMap { (name, lang, isOn) -> URL? in
        guard isOn else { return nil }
        return name.flatMap {
            $0.count > 3 ? URL(string: "https://api.github.com/search/repositories?q=\($0)+language:\(lang)") : nil
        }
    }
    .removeDuplicates()
    .mapError { $0 as Error }
    .map {
        return URLSession.shared.cx.dataTaskPublisher(for: $0).mapError { $0 as Error }
    }
    .switchToLatest()
    .map {
        processSearchResult($0.data)
    }
    .replaceError(with: "Bad response.")
    .bind(to: self.logTextView.cx.text)
    .cancel(by: self)
```

## Combine 与 CombineX

Combine 是 Apple 在 WWDC 2019 上推出的响应式框架，它参考了 ReactiveX 的接口设计，为 Swift 异步编程提供了钦定实现。我相信几年后它会成为 Swift 编程的重要基石。不幸的是，它是闭源的，同时还有着严格的平台限制（Darwin only）和版本限制（iOS 13+, macOS 10.15+）。

[CombineX](https://github.com/luoxiu/CombineX) 是 Combine 的开源实现，它的目的是实现与 Combine 完全一致的 API，让开发者摆脱 Combine 的限制，在任何平台（linux），任何版本（iOS 10+, macOS 10.12+）都能自由地书写相同的代码。

目前，CombineX 已经粗略实现了所有的 Combine 功能。

## 试下

CocoaPods

```ruby
# mandatory use of master branch
pod 'CombineX.swift', :git => 'https://github.com/luoxiu/CombineX.git', :branch => 'master'
pod 'CombineX.Foundation', :git => 'https://github.com/luoxiu/CombineX.Foundation.git', :branch => 'master'
  

pod 'CombineX.Cocoa', '~> 0.0.1-beta.3'
```

## 贡献

欢迎！任何时候任何形式的贡献都是欢迎的！！！

你可以：

1. 添加更多的控件扩展，尤其是 macOS 控件
2. 添加文档注释
3. 提出你对本项目的建议

**因为上游 CombineX 还在测试阶段，如果你在本库遇到了奇怪的问题——那么它有可能是上游漂流下来的问题。🤣**