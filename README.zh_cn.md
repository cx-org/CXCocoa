# CombineX.Cocoa

[![release](https://img.shields.io/github/release-pre/cx-org/CXCocoa)](https://github.com/cx-org/CXCocoa/releases)
![install](https://img.shields.io/badge/install-cocoapods%20%7C%20carthage-ff69b4)
![platform](https://img.shields.io/badge/platform-ios%20%7C%20macos%20%7C%20watchos%20%7C%20tvos-lightgrey)
![license](https://img.shields.io/github/license/cx-org/CXCocoa?color=black)
[![dicord](https://img.shields.io/badge/chat-discord-9cf)](https://discord.gg/9vzqgZx)

## 注意

本库还在 beta，所以，**还不可以把它用在生产中！**

🐱

## 什么是 CXCocoa

与 ReactiveCocoa 和 ReaciveSwift, RxCocoa 和 RxSwift 的关系一样，CXCocoa 是 [CombineX](https://github.com/cx-org/CombineX) 的衍生库。它为 Cocoa Framework 框架提供了 [Combine](https://developer.apple.com/documentation/combine) 扩展，让你可以更方便地书写 Cocoa 相关的异步代码。

它包括但不限于：

- MethodPublisher/DeallocatePublisher，通过 Runtime 拦截方法调用
- KVOPublisher，通过 KVO 机制观察属性变化
- DelegateProxy，通过 Runtime 转发代理消息
- UIKit extensions（binder + property），订阅控件事件，绑定值
- UIScheduler
- ...

你可以自由地在 `CombineX` 和 `Combine` 之间切换底层依赖。

## 实例

<p align="center">
<img src="demo.1.gif" height="500">
<img src="demo.2.gif" height="500">
</p>

## 安装

### CocoaPods

```ruby
pod 'CXCocoa', :git => 'https://github.com/cx-org/CXCocoa.git', :branch => 'master'
```

### Carthage

```carthage
github "cx-org/CXCocoa" "master"
```

## 什么是 Combine/CombineX

看[这里](https://github.com/cx-org/CombineX#what-is-combine).

## 贡献

欢迎！任何时候任何形式的贡献都是欢迎的！！！

你可以：

1. 添加更多的控件扩展，尤其是 macOS 控件
2. 添加文档注释
3. 提出你对本项目的建议
4. Star！然后告诉你的朋友们！

**因为上游 CombineX 还在测试阶段，如果你在本库遇到了奇怪的问题——那么它有不小可能是上游漂流下来的。🤣**


## 在 Combine 中使用

你可以通过传入 `USE_COMBINE` 到 build configurations 来切换底层依赖到 `Combine`。比如说，如果你在用 CocoaPods，你可以如下所示修改你的 podfile：

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

如果你在用 Carthage，你应该可以通过 `XCODE_XCCONFIG_FILE` 来实现.

## 致谢

该库的实现同时参考了 [ReactiveCocoa](https://github.com/ReactiveCocoa/ReactiveCocoa) 和 [RxCocoa](https://github.com/ReactiveX/RxSwift)，尤其是 ReactiveCocoa，ObjC 的部分几乎完全修改自它的源码。为他们的工作表示由衷的感谢！
