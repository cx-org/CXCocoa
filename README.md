# CombineX.Cocoa([中文](README.zh_cn.md))

![swift](https://img.shields.io/badge/swift-5.0-orange)
![install](https://img.shields.io/badge/install-spm%20%7C%20cocoapods%20%7C%20carthage-ff69b4)
![platform](https://img.shields.io/badge/platform-ios%20%7C%20macos%20%7C%20watchos%20%7C%20tvos-lightgrey)
![license](https://img.shields.io/github/license/luoxiu/combinex?color=black)

## Notice

This library is still in beta, so **do not use it in production!**

🐱

## What is CombineX.Cocoa

Like ReactiveCocoa and ReaciveSwift, RxCocoa and RxSwift, CombineX.Cocoa is a derivative of [CombineX.swift](https://github.com/luoxiu/CombineX). It provides CombineX extensions to Cocoa Framework, which allows you to write Cocoa-related asynchronous code in an elegant way.

It includes but is not limited to：

- KVOPublisher, observing property changes through the KVO mechanism
- MethodPublisher/DeallocatePublisher, tntercepting Method calls with Method Swizzle
- UIKit binder&property, subscribing control event and binding values
- Delegate proxy
- UIScheduler
- ... 

It's all based on [CombineX](https://github.com/luoxiu/CombineX). **After the official release of Combine, you are free to switch the underlying support.**


## Demo

<p align="center">
<img src="demo.1.gif" height="500">
<img src="demo.2.gif" height="500">
</p>

## Combine and CombineX

Combine is reactive framework published by Apple on WWDC 2019. It refers to the ReactiveX's interface design and provides an official implementation for Swift asynchronous programming. I believe it will become an important cornerstone of Swift programming in a few years. Unfortunately, it's closed source, with strict platform limits (Darwin only) and version restrictions (iOS 13+, macOS 10.15+).

[CombineX](https://github.com/luoxiu/CombineX) is an open source implementation of Combine. Its purpose is to implement an API that is fully consistent with Combine, allowing developers to get rid of the limitations of Combine, to write the same code on any platform (linux), any The version (iOS 10+, macOS 10.12+).

Currently, CombineX has roughly implemented all of the Combine features.

## Try it out

### CocoaPods

```ruby
# mandatory use of master branch
pod 'CombineX.swift', :git => 'https://github.com/luoxiu/CombineX.git', :branch => 'master'
pod 'CombineX.Foundation', :git => 'https://github.com/luoxiu/CombineX.Foundation.git', :branch => 'master'
  

pod 'CombineX.Cocoa', :git => 'https://github.com/luoxiu/CombineX.Cocoa.git', :branch => 'master'
```

## Contribution

Welcome! Any kind of contribution is welcome at any time! ! !

You can:

1. Add more control extensions, especially for macOS controls.
2. Add documentation.
3. Make your suggestions(new feature, improvement, bug...)

**Because the upstream CombineX is still in beta, if you encounter a strange problem in this library - then it may drift from upstream. 🤣**

## Acknowledgement

The implementation of the library references both reactivecocoa and rxswift, especially ReactiveCocoa, The ObjC part completely modified from its source code. Great thanks to their work!