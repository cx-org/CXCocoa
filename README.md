# CombineX.Cocoa([中文](README.zh_cn.md))

![swift](https://img.shields.io/badge/swift-5.0-orange)
![install](https://img.shields.io/badge/install-spm%20%7C%20cocoapods%20%7C%20carthage-ff69b4)
![platform](https://img.shields.io/badge/platform-ios%20%7C%20macos%20%7C%20watchos%20%7C%20tvos-lightgrey)
![license](https://img.shields.io/github/license/luoxiu/combinex?color=black)

## Notice

This library is still in beta, so **do not use it in production!**

🐱

## What is CombineX.Cocoa

Like ReactiveCocoa and ReaciveSwift, RxCocoa and RxSwift, CombineX.Cocoa is a derivative of [CombineX](https://github.com/luoxiu/CombineX). It provides [Combine](https://developer.apple.com/documentation/combine) extensions to Cocoa Framework, which allows you to write Cocoa-related asynchronous code in an elegant way.

It includes but is not limited to：

- MethodPublisher/DeallocatePublisher, intercepting method calls with method swizzle
- KVOPublisher, observing property changes through the KVO mechanism
- DelegateProxy, forwarding delegate message
- UIKit extensions(binder & property), subscribing control event and binding values
- UIScheduler
- ...

It's all based on [CombineX](https://github.com/luoxiu/CombineX). **After the official release of Combine, you are free to switch the underlying support.**

## Demo

<p align="center">
<img src="demo.1.gif" height="500">
<img src="demo.2.gif" height="500">
</p>

## Install

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

## What is Combine

Combine is a responsive framework published by Apple at WWDC 2019, which refers to the interface design of [ReactiveX](http://reactivex.io/) and provides Apple's preferred implementation for Swift asynchronous programming. It will definitely be the cornerstone of Swift programming in the foreseeable future.

## What is CombineX

CombineX is an open source implementation of Combine. In addition to having an API and behavior consistent with Combine, it has the following advantages:

### 1. Versions and Platforms

`Combine` has very high version restrictions: macOS 10.15+, iOS 13+. In other words, even if your app only needs to be compatible with two versions forward, it will take two to three years before you can use it. `Combine` is exclusive to the Apple platform and does not support Linux.

`CombineX` helps you get rid of these limitations, it supports macOS 10.12+, iOS 10+, and supports Linux. With `CombineX`, you can use the same code on more platforms and versions.

### 2. Open source

'Combine' is closed source, it is like 'UIKit', 'MapKit', etc., updated with the update of Xcode. When you encounter a bug, "you should have encountered a system library bug," debugging is very annoying, but more annoying is the slow official response, usually, you can't do anything but wait for the next regular update of Xcode.

### 3. Extensions

`CombineX` provides a number of related extensions, including but not limited to:

- [CombineX.Foundation](https://github.com/luoxiu/CombineX.Foundation): provides all `Foundation` extension implementations, built on top of `CombineX`. For example, `URLSession`, `NotificationCenter`, `Timer`, `DispatchQueue+Scheduler`, `RunLoop+Scheduler`, etc.
- [CombineX.Cocoa](https://github.com/luoxiu/CombineX.Foundation): provides `Cocoa` extension implementations, built on top of `CombineX`. For example, `KVOPublisher`, `MethodInterceptionPublisher`, `UIKit+CX`, etc.
- [CombineX.Compatible](https://github.com/CombineXCommunity/CombineX.Compatible): provides API Shims for `CombineX` to help you resolve migration concerns that may arise. With this library, you can easily switch the underlying library from `CombineX` to `Combine` at any time.

**Currently, CombineX has roughly implemented all of the Combine features.**

## Contribution

Welcome! Any kind of contribution is welcome at any time! ! !

You can:

1. Add more control extensions, especially for macOS controls.
2. Add documentation.
3. Make your suggestions(new feature, improvement, bug...)

**Because the upstream CombineX is still in beta, if you encounter a strange problem in this library - then it may drift from upstream. 🤣**

## Acknowledgement

The implementation of the library references both [ReactiveCocoa](https://github.com/ReactiveCocoa/ReactiveCocoa) and [RxCocoa](https://github.com/ReactiveX/RxSwift), especially ReactiveCocoa, the ObjC part is almost completely modified from its source code, really appreciate to their great work!
