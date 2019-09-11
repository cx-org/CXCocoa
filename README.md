# CombineX.Cocoa([中文](README.zh_cn.md))

[![release](https://img.shields.io/github/release-pre/cx-org/CXCocoa)](https://github.com/cx-org/CXCocoa/releases)
![install](https://img.shields.io/badge/install-cocoapods%20%7C%20carthage-ff69b4)
![platform](https://img.shields.io/badge/platform-ios%20%7C%20macos%20%7C%20watchos%20%7C%20tvos-lightgrey)
![license](https://img.shields.io/github/license/cx-org/CXCocoa?color=black)
[![dicord](https://img.shields.io/badge/chat-discord-9cf)](https://discord.gg/cresT3X)

## Notice

This library is still in beta, so **do not use it in production!**

🐱

## What is CXCocoa

Like ReactiveCocoa and ReaciveSwift, RxCocoa and RxSwift, CXCocoa is a derivative of [CombineX](https://github.com/cx-org/CombineX). It provides [Combine](https://developer.apple.com/documentation/combine) extensions to Cocoa Framework, making it easier to write Cocoa-related asynchronous code.

It includes but is not limited to：

- MethodPublisher/DeallocatePublisher, intercepting method calls with method swizzle
- KVOPublisher, observing property changes through the KVO mechanism
- DelegateProxy, forwarding delegate message
- UIKit extensions(binder & property), subscribing control event and binding values
- UIScheduler
- ...

You can freely switch the underlying dependency between `CombineX` and `Combine`.

## Demo

<p align="center">
<img src="demo.1.gif" height="500">
<img src="demo.2.gif" height="500">
</p>

## Install

### CocoaPods

```ruby
pod 'CXCocoa', :git => 'https://github.com/cx-org/CXCocoa.git', :branch => 'master'
```

### Carthage

```carthage
github "cx-org/CXCocoa" "master"
```

## What is Combine/CombineX

Check [here](https://github.com/cx-org/CombineX#what-is-combine).

## Contribution

Welcome! Any kind of contribution is welcome at any time!!!

You can:

1. Add more control extensions, especially for macOS controls.
2. Add documentation.
3. Make your suggestions.
4. Star! Then tell your friends!

**Because the upstream CombineX is still in beta, if you encounter a strange problem in this library - then it may drift from upstream. 🤣**

## Use with Combine

You can change the underlying dependency to `Combine` by passing `USE_COMBINE` to the target's build configurations. For example, if you are using CocoaPods, you can modify your podfile like below:

```ruby
post_install do |installer|
    installer.pods_project.targets.each do |target|
        if target.name == 'CXExtensions'
            target.build_configurations.each do |config|
                config.build_settings['OTHER_SWIFT_FLAGS'] = '-DUSE_COMBINE'
            end
        end
    end
end
```

If you are using Carthage, you should be able to use `XCODE_XCCONFIG_FILE` to do that.

## Acknowledgement

The implementation of the library references both [ReactiveCocoa](https://github.com/ReactiveCocoa/ReactiveCocoa) and [RxCocoa](https://github.com/ReactiveX/RxSwift), especially ReactiveCocoa, the ObjC part is almost completely modified from its source code, really appreciate to their great work!
