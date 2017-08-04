# Change Log
All notable changes to this project will be documented in this file.
`APExtensions` adheres to [Semantic Versioning](http://semver.org/).

## [3.2.0](https://github.com/APUtils/APExtensions/releases/tag/3.2.0)
Released on 08/03/2017.

#### Added
- UIImage+Utils .screenFitImage
- No need to call APExtensions.prepare() anymore
- SetupOnce classes called automatically
  - Added by [Anton Plebanovich](https://github.com/anton-plebanovich).

## [3.1.0](https://github.com/APUtils/APExtensions/releases/tag/3.1.0)
Released on 07/31/2017.

#### Added
- Data? .isNilOrEmpty
- Date .isWeekend, .isYesterday
- UIButton .setTitle
- Date .nextDay
- UIViewController+Storyboard .hideKeyboardOnTouch
- UIButton .lines
- Utils .g_showPickerAlert(...)
- Utils .g_statusBarStyleTopViewController
  - Added by [Anton Plebanovich](https://github.com/anton-plebanovich).

#### Changed
- UIView made .endEditing @IBAction
  - Added by [Anton Plebanovich](https://github.com/anton-plebanovich).

#### Fixed
- UIImage resize rendering mode fix
- AlerController status bar style fix
  - Added by [Anton Plebanovich](https://github.com/anton-plebanovich).

## [3.0.0](https://github.com/APUtils/APExtensions/releases/tag/3.0.0)
Released on 07/20/2017.

#### Added
- Manager protocol
- SetupOnce protocol
- UIScrollView refresh control methods
- Date .startOfDay and .gmtDayBeginningDate
- UIView animations
- UIViewController .isBeingRemoved
- UIView .viewController
  - Added by [Anton Plebanovich](https://github.com/anton-plebanovich).

## [2.0.0](https://github.com/APUtils/APExtensions/releases/tag/2.0.0)
Released on 07/18/2017.

#### Added
- Configurable protocol
- Date+Utils getString()
- NSLayoutConstraint+Storyboard .fitScreenSize, .onePixelSize
- Restoration of previous value when setting .fitScreenSize to false (except UIImageView)
- Date+Utils .isToday
- NSCoder+Utils more decode methods with default value
- MFMailComposeViewController+Utils create(to:)
- MFMessageComposeViewController+Utils create(phone:)
- UIApplication+Utils makeCall(phone:), sendEmail(to:)
- Error+Utils .isConnectError
- UINavigationBar+Utils setTransparent(_:)
  - Added by [Anton Plebanovich](https://github.com/anton-plebanovich).

#### Renamed
- .fitSize -> .fitScreenSize
- Creatable -> InstantiatableFromStoryboard
  - Added by [Anton Plebanovich](https://github.com/anton-plebanovich).

## [1.0.2](https://github.com/APUtils/APExtensions/releases/tag/1.0.2)
Released on 07/11/2017.

#### Added
- NSCoder+Utils
  - Added by [Anton Plebanovich](https://github.com/anton-plebanovich).

## [1.0.1](https://github.com/APUtils/APExtensions/releases/tag/1.0.1)
Released on 07/11/2017.

#### Added
- Debug logs
  - Added by [Anton Plebanovich](https://github.com/anton-plebanovich).

## [1.0.0](https://github.com/APUtils/APExtensions/releases/tag/1.0.0)
Released on 07/11/2017.

#### Added
- Initial release of APExtensions.
  - Added by [Anton Plebanovich](https://github.com/anton-plebanovich).
