# APExtensions

[![Swift Package Manager compatible](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)
[![Version](https://img.shields.io/cocoapods/v/APExtensions.svg?style=flat)](http://cocoapods.org/pods/APExtensions)
[![License](https://img.shields.io/cocoapods/l/APExtensions.svg?style=flat)](http://cocoapods.org/pods/APExtensions)
[![Platform](https://img.shields.io/cocoapods/p/APExtensions.svg?style=flat)](http://cocoapods.org/pods/APExtensions)
[![CI Status](http://img.shields.io/travis/APUtils/APExtensions.svg?style=flat)](https://travis-ci.org/APUtils/APExtensions)

A helpful collection of extensions, controllers and protocols

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

#### Swift Package Manager

- In Xcode select `File` > `Add Packages...`
- Copy and paste the following into the search: `https://github.com/APUtils/APExtensions`
- **‼️Make sure `Up to Next Major Version` is selected and put `14.2.0` into the lower bound. There is a bug in Xcode, it does not select versions higher than 9.0.0 by default‼️**
- Tap `Add Package`
- Select `APExtension` to add everything and tap `Add Package`

#### CocoaPods

APExtensions is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'APExtensions', '~> 14.2'
```

Available subspecs: `Core`, `Storyboard`, `ViewModel`. Example Podfile for subspec:

```ruby
pod 'APExtensions/Core', '~> 14.2'
pod 'APExtensions/Storyboard', '~> 14.2'
pod 'APExtensions/ViewModel', '~> 14.2'
```

## Usage

See [documentation](http://cocoadocs.org/docsets/APExtensions) for more details.

### Core

Global Utils and Debug methods, Controllers, Protocols and whole lot of default classes extensions. Read more in [DOCS](https://aputils.github.io/APExtensions/).

### ViewModel

Adds `ViewModel` struct and `.configure(vm:)` method to views so it's easy and robust to configure them.

### ViewState

Moved to https://github.com/APUtils/ViewState

### Storyboard

Extends default attributes that can be configured using storyboard.


**NSLayoutConstraint**:

<img src="https://github.com/APUtils/APExtensions/raw/master/Example/APExtensions/nslayoutconstraint.png"/>

- `fitScreenSize` to adjust constraint constant according to screen size. [*](https://github.com/APUtils/APExtensions#remark)
- `onePixelSize` to make constraint 1 pixel size

**UIButton**:

<img src="https://github.com/APUtils/APExtensions/raw/master/Example/APExtensions/uibutton.png"/>

- `fitScreenSize` to adjust font size according to screen size. [*](https://github.com/APUtils/APExtensions#remark)
- `lines` to change title label max lines count

**UIImageView**:

<img src="https://github.com/APUtils/APExtensions/raw/master/Example/APExtensions/UIImageView.png"/>

- `fitScreenSize` to adjust image size according to screen size. [*](https://github.com/APUtils/APExtensions#remark)
- `localizableImageName` to use localize specific image. You name your images like `image_en`, `image_ru`, `image_fr` put `image` in `localizableImageName` field and assure you localized `_en` to be `_fr` for French localization, `_ru` for Russian and so on.

**UILabel**:

<img src="https://github.com/APUtils/APExtensions/raw/master/Example/APExtensions/UILabel.png"/>

- `fitScreenSize` to adjust font size according to screen size. [*](https://github.com/APUtils/APExtensions#remark)

**UIScrollView**:

<img src="https://github.com/APUtils/APExtensions/raw/master/Example/APExtensions/UIScrollView.png"/>

- `avoidTopBars` to set contentInset.top to 64
- `avoidTabBar` to set contentInset.bottom to 49

**UITextView**:

<img src="https://github.com/APUtils/APExtensions/raw/master/Example/APExtensions/UITextView.png"/>

- `fitScreenSize` to adjust font size according to screen size. [*](https://github.com/APUtils/APExtensions#remark)

**UIView**:

<img src="https://github.com/APUtils/APExtensions/raw/master/Example/APExtensions/uiview.png"/>

- `borderColor` to set border color
- `borderWidth` to set border width
- `borderOnePixelWidth` to make border 1 pixel width
- `cornerRadius` to set corners radius
- `shadowColor` to set shadow color
- `shadowOffset` to set shadow offset
- `shadowOpacity` to set shadow opacity
- `shadowRadius` to set shadow radius
- `shadowApplyPath` to apply view bounds rect as shadow pass. Greatly improves performance for opaque views.

**UIViewController**:

<img src="https://github.com/APUtils/APExtensions/raw/master/Example/APExtensions/UIViewController.png"/>

- `hideKeyboardOnTouch` to hide keyboard on touch outside it

#### Remark

Assuming layout was made for highest screen size (iPhone 6+, 6s+, 7+) so subject will be reduced propotionally on lower resolution screens.

### Occupiable

`Occupiable` protocol

### OptionalType

`OptionalType` protocol

## Contributions

Any contribution is more than welcome! You can contribute through pull requests and issues on GitHub.

## Author

Anton Plebanovich, anton.plebanovich@gmail.com

## License

APExtensions is available under the MIT license. See the LICENSE file for more info.
