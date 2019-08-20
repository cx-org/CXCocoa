# CombineX.Cocoa

![GitHub release (latest by date including pre-releases)](https://img.shields.io/github/v/release/luoxiu/combinex.cocoa?include_prereleases)
![swift](https://img.shields.io/badge/swift-5.0-orange)
![platform](https://img.shields.io/badge/platform-ios%20%7C%20macos%20%7C%20watchos%20%7C%20tvos-lightgrey)

## Notice

This library is still in beta testing, **Please do not use it in production!**

🐱

## What is CombineX.Cocoa

Like ReactiveCocoa and ReaciveSwift, RxCocoa and RxSwift, CombineX.Cocoa is a derivative of [CombineX.swift](https://github.com/luoxiu/CombineX). It provides [Combine](https://developer.apple.com/documentation/combine) extensions to Cocoa Framework, which allows you to write Cocoa-related asynchronous code in an elegant way that is compatible with Combine.

It includes：

- KVOPublisher, observing property changes through the KVO mechanism
- MethodPublisher/DeallocatePublisher, tntercepting Method calls with Method Swizzle
- UIKit binder&property, subscribing control event and binding values
- Delegate proxy
- UIScheduler
- ... 

It's all based on [CombineX] (https://github.com/luoxiu/CombineX). **After the official release of Combine, you are free to switch the underlying support. **


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

## Combine and CombineX

Combine is reactive framework published by Apple on WWDC 2019. It refers to the ReactiveX's interface design and provides an official implementation for Swift asynchronous programming. I believe it will become an important cornerstone of Swift programming in a few years. Unfortunately, it's closed source, with strict platform limits (Darwin only) and version restrictions (iOS 13+, macOS 10.15+).

[CombineX] (https://github.com/luoxiu/CombineX) is an open source implementation of Combine. Its purpose is to implement an API that is fully consistent with Combine, allowing developers to get rid of the limitations of Combine, to write the same code on any platform (linux), any The version (iOS 10+, macOS 10.12+).

Currently, CombineX has roughly implemented all of the Combine features.

## Try it out

### CocoaPods

```ruby
# mandatory use of master branch
pod 'CombineX.swift', :git => 'https://github.com/luoxiu/CombineX.git', :branch => 'master'
pod 'CombineX.Foundation', :git => 'https://github.com/luoxiu/CombineX.Foundation.git', :branch => 'master'
  

pod 'CombineX.Cocoa', '~> 0.0.1-beta.3'
```

## Contribution

Welcome! Any kind of contribution is welcome at any time! ! !

You can:

1. Add more control extensions, especially for macOS controls.
2. Add documentation.
3. Make your suggestions(new feature, improvement, bug...)

**Because the upstream CombineX is still in beta, if you encounter a strange problem in this library - then it may drift from upstream. 🤣**