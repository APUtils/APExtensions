# Change Log
All notable changes to this project will be documented in this file.
`APExtensions` adheres to [Semantic Versioning](http://semver.org/).

## [4.0.0](https://github.com/APUtils/APExtensions/releases/tag/4.0.0)
Released on 09/21/2017.

#### Added
- Default param for enter text alert
- Array .enumerateForEach to enumerate objects and indexes
- TableViewCellInformation protocol
- UIImage .image(withOverlayImage:)
- CGPoint +=, -=
- UIImageView .setImageAnimated(_:)
- DelayedValue abstraction
- UIStackView .removeAllArrangedSubviews(), replaceArrangedSubviews(_:)
- String .height(font:width:), .height(attributes:width:)
- NSAttributedString .height(width:)

#### Changed
- Swift 4 migration
- Moved activity indicator logic to UIView from UIViewController

#### Fixed
- Assure presenting alert on main thread only

## [3.7.0](https://github.com/APUtils/APExtensions/releases/tag/3.7.0)
Released on 08/28/2017.

#### Added
- SuccessClosure
- Dictionary .arrayOfInts(forKey:), .arrayOfDoubles(forKey:), .arrayOfBools(forKey:), .arrayOfStrings(forKey:), .arrayOfDictionaries(forKey:)

#### Changed
- UIView .becomeFirstResponderOnViewDidAppear is @IBInspectable now


## [3.6.0](https://github.com/APUtils/APExtensions/releases/tag/3.6.0)
Released on 08/02/2017.

#### Added
- `Core` podspec

#### Changed
- Migrated ViewState related extensions into `ViewState` podspec


## [3.5.1](https://github.com/APUtils/APExtensions/releases/tag/3.5.1)
Released on 08/16/2017.

#### Changed
- Date .getString() relative by default


## [3.4.10](https://github.com/APUtils/APExtensions/releases/tag/3.4.10)
Released on 08/16/2017.

#### Fixed
- Debug log spam


## [3.4.9](https://github.com/APUtils/APExtensions/releases/tag/3.4.9)
Released on 08/16/2017.

#### Fixed
- Day start notification name public access


## [3.4.8](https://github.com/APUtils/APExtensions/releases/tag/3.4.8)
Released on 08/16/2017.

#### Changed
- Manager protocol is @objc now


## [3.4.7](https://github.com/APUtils/APExtensions/releases/tag/3.4.7)
Released on 08/15/2017.

#### Added
- g_getClassesConformToProtocol(_:)


## [3.4.6](https://github.com/APUtils/APExtensions/releases/tag/3.4.6)
Released on 08/15/2017.

#### Added
- NotificationCenter .startDayNotifications() and .stopDayNotifications()


## [3.4.5](https://github.com/APUtils/APExtensions/releases/tag/3.4.5)
Released on 08/14/2017.

#### Fixed
- UIViewControllerWillMoveToParentViewController fix


## [3.4.4](https://github.com/APUtils/APExtensions/releases/tag/3.4.4)
Released on 08/14/2017.

#### Added
- UIViewControllerWillMoveToParentViewController notification

#### Fixed
- Name typo fix splitedByCapitals -> splittedByCapitals


## [3.4.3](https://github.com/APUtils/APExtensions/releases/tag/3.4.3)
Released on 08/09/2017.

#### Added
- Storyboard README section


## [3.4.2](https://github.com/APUtils/APExtensions/releases/tag/3.4.2)
Released on 08/09/2017.

#### Added
- Storyboard subspec


## [3.4.1](https://github.com/APUtils/APExtensions/releases/tag/3.4.1)
Released on 08/09/2017.

#### Fixed
- Public attributes fix


## [3.4.0](https://github.com/APUtils/APExtensions/releases/tag/3.4.0)
Released on 08/08/2017.

#### Added
- Carthage support

#### Changed
- String .splitByCapitals() -> .splitByCapitals


## [3.3.1](https://github.com/APUtils/APExtensions/releases/tag/3.3.1)
Released on 08/08/2017.

#### Added
- ViewState subspec


## [3.3.0](https://github.com/APUtils/APExtensions/releases/tag/3.3.0)
Released on 08/04/2017.

#### Added
- Character .isUpperCase
- Sequence .splitBefore(...)
- String .splitByCapitals()

#### Removed
- APExtensions class. Made private loader.


## [3.2.0](https://github.com/APUtils/APExtensions/releases/tag/3.2.0)
Released on 08/03/2017.

#### Added
- UIImage+Utils .screenFitImage
- No need to call APExtensions.prepare() anymore
- SetupOnce classes called automatically


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

#### Changed
- UIView made .endEditing @IBAction

#### Fixed
- UIImage resize rendering mode fix
- AlerController status bar style fix


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

#### Renamed
- .fitSize -> .fitScreenSize
- Creatable -> InstantiatableFromStoryboard


## [1.0.2](https://github.com/APUtils/APExtensions/releases/tag/1.0.2)
Released on 07/11/2017.

#### Added
- NSCoder+Utils


## [1.0.1](https://github.com/APUtils/APExtensions/releases/tag/1.0.1)
Released on 07/11/2017.

#### Added
- Debug logs


## [1.0.0](https://github.com/APUtils/APExtensions/releases/tag/1.0.0)
Released on 07/11/2017.

#### Added
- Initial release of APExtensions.
  - Added by [Anton Plebanovich](https://github.com/anton-plebanovich).
