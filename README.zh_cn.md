# CombineX.Cocoa

![swift](https://img.shields.io/badge/swift-5.0-orange)
![install](https://img.shields.io/badge/install-cocoapods%20%7C%20carthage-ff69b4)
![platform](https://img.shields.io/badge/platform-ios%20%7C%20macos%20%7C%20watchos%20%7C%20tvos-lightgrey)
![license](https://img.shields.io/github/license/luoxiu/combinex?color=black)

## 注意

本库仍在 beta 测试，所以，**还不可以把它用在生产项目中！**

🐱

## 什么是 CombineX.Cocoa

与 ReactiveCocoa 和 ReaciveSwift, RxCocoa 和 RxSwift 的关系一样，CombineX.Cocoa 是 [CombineX.swift](https://github.com/luoxiu/CombineX) 的衍生库。它为 Cocoa Framework 框架提供了 [Combine](https://developer.apple.com/documentation/combine) 扩展，让你可以更优雅书写 Cocoa 相关的异步代码。

它包括但不限于：

- MethodPublisher/DeallocatePublisher，通过 Runtime 拦截方法调用
- KVOPublisher，通过 KVO 机制观察属性变化
- DelegateProxy，通过 Runtime 转发代理消息
- UIKit extensions（binder + property），订阅控件事件，绑定值
- UIScheduler
- ...

这一切都基于 [CombineX](https://github.com/luoxiu/CombineX) 实现。**但是，在 Combine 正式发布后，你可以自由地切换底层支援。**

## 实例

<p align="center">
<img src="demo.1.gif" height="500">
<img src="demo.2.gif" height="500">
</p>

## 安装

### CocoaPods

```ruby
# forcing master branches for now.
pod 'CombineX.swift', :git => 'https://github.com/luoxiu/CombineX.git', :branch => 'master'
pod 'CombineX.Foundation', :git => 'https://github.com/luoxiu/CombineX.Foundation.git', :branch => 'master'
  

pod 'CombineX.Cocoa', :git => 'https://github.com/luoxiu/CombineX.Cocoa.git', :branch => 'master'
```

### Carthage

```carthage
github "luoxiu/CombineX" "master"
github "luoxiu/CombineX.Foundation" "master"

github "luoxiu/CombineX.Cocoa" "master"
```

## 什么是 Combine

Combine 是 Apple 在 WWDC 2019 上推出的响应式框架，它「参考」了 [ReactiveX](http://reactivex.io/) 的接口设计，为 Swift 异步编程提供了钦定实现。在可预见的将来，它一定会成为 Swift 编程的基石。

## 什么是 CombineX

[CombineX](https://github.com/luoxiu/CombineX) 是 Combine 的开源实现。除了有着与 Combine 一致的 API 和行为，它还有以下优势：

### 1. 版本与平台

`Combine` 有极高的版本限制：macOS 10.15+，iOS 13+。也就是说，即使你的 App 只需要向前兼容两个版本，也需要两三年后才能用得上它。`Combine` 是 Apple 平台独占的，不支持 Linux。

`CombineX` 帮你摆脱了这些限制，它支持 macOS 10.12+，iOS 10+，支持 Linux。通过 `CombineX`，你可以在更多的平台和版本上使用相同的代码。

### 2. 开源

`Combine` 是闭源的，它与 `UIKit`，`MapKit` 等一样，随着 xcode 的更新而更新。当你遇到 bug 时，「你应该遇到过系统库的 bug 吧」，调试是非常烦人的，但更烦人的是缓慢的官方反应，通常你除了等待下一次 xcode 的常规更新以外无能为力。

### 3. 扩展

`CombineX` 贴心地为你提供了诸多相关扩展，包括但不限于：

- [CombineX.Foundation](https://github.com/luoxiu/CombineX.Foundation)：提供所有 `Foundation` 的扩展实现，基于 `CombineX`。比如 `URLSession`，`NotificationCenter`，`Timer`，`DispatchQueue+Scheduler`，`RunLoop+Scheduler`等。
- [CombineX.Cocoa](https://github.com/luoxiu/CombineX.Foundation)：提供 `Cocoa` 的扩展实现，基于 `CombineX`。比如 `KVOPublisher`，`MethodInterceptionPublisher`，`UIKit+CX` 等。
- [CombineX.Compatible](https://github.com/CombineXCommunity/CombineX.Compatible)：提供 `CombineX` 的 API Shims，帮助你解决可能会出现的迁移顾虑。通过该库，你可以在任何时候轻松地被底层库从 `CombineX` 切换到 `Combine`。

**目前，CombineX 已经粗略实现了 Combine 的所有功能。**

## 贡献

欢迎！任何时候任何形式的贡献都是欢迎的！！！

你可以：

1. 添加更多的控件扩展，尤其是 macOS 控件
2. 添加文档注释
3. 提出你对本项目的建议（新功能，改进，bug...）

**因为上游 CombineX 还在测试阶段，如果你在本库遇到了奇怪的问题——那么它有不小可能是上游漂流下来的问题。🤣**

## 致谢

该库的实现同时参考了 [ReactiveCocoa](https://github.com/ReactiveCocoa/ReactiveCocoa) 和 [RxCocoa](https://github.com/ReactiveX/RxSwift)，尤其是 ReactiveCocoa，ObjC 的部分几乎完全修改自它的源码。为它们的工作表示由衷的感谢！
