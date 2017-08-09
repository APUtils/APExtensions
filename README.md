# APExtensions

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Version](https://img.shields.io/cocoapods/v/APExtensions.svg?style=flat)](http://cocoapods.org/pods/APExtensions)
[![License](https://img.shields.io/cocoapods/l/APExtensions.svg?style=flat)](http://cocoapods.org/pods/APExtensions)
[![Platform](https://img.shields.io/cocoapods/p/APExtensions.svg?style=flat)](http://cocoapods.org/pods/APExtensions)
[![CI Status](http://img.shields.io/travis/APUtils/APExtensions.svg?style=flat)](https://travis-ci.org/APUtils/APExtensions)

A helpful collection of extensions, controllers and protocols

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

#### Carthage

Please check [official guide](https://github.com/Carthage/Carthage#if-youre-building-for-ios-tvos-or-watchos)

Cartfile:

```
github "APUtils/APExtensions"
```

#### CocoaPods

APExtensions is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'APExtensions'
```

Available subspecs: ViewState. Example Podfile for subspec:

```ruby
pod 'APExtensions/ViewState'
```

## Usage

#### ViewState

Extends UIViewController with .viewState enum property. Possible cases: `.notLoaded`, `.didLoad`, `.willAppear`, `.didAppear`, `.willDisappear`, `.didDisappear`.

Also every UIViewController starts to send notifications about its state change. Available notifications to observe: `.UIViewControllerViewDidLoad`, `.UIViewControllerViewWillAppear`, `.UIViewControllerViewDidAppear`, `.UIViewControllerViewWillDisappear`, `.UIViewControllerViewDidDisappear`

See example project for more details.

## Contributions

Any contribution is more than welcome! You can contribute through pull requests and issues on GitHub.

## Author

Anton Plebanovich, anton.plebanovich@gmail.com

## License

APExtensions is available under the MIT license. See the LICENSE file for more info.
