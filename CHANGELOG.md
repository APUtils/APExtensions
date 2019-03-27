# Change Log
All notable changes to this project will be documented in this file.
`APExtensions` adheres to [Semantic Versioning](http://semver.org/).

## [7.0.0](https://github.com/APUtils/APExtensions/releases/tag/7.0.0)
Released on 27.03.2019.

#### Added
- Swift 5.0 support
- Array .hasIntersection(with:)
- Array appendMissing(contentsOf:)
- Array remove(contentsOf:)
- c.cacheDirectoryUrl
- c.documentsDirectoryUrl
- c.isIPhone
- c.isSimulator
- c.navigationBarHeight
- c.pixelSize
- c.screenScale
- c.screenSize
- c.statusBarHeight
- c.tempDirectoryUrl
- c.topBarsHeight
- Conform Manager to class and ClassName
- Date .adding(dateComponents:)
- Error .isCancelledError
- Error .isConnectError -> isConnectionError
- g.isIPhone
- InstantiatableContentView .createAndAttachContentView() for UIView
- Int .isEven
- Int .isOdd
- Missing substring warnings
- New class Constants and global 'c' variable to group all constants
- NSMutableAttributedString .setStrikethrough(text:)
- ScrollViewCustomHorizontalPageSize protocol
- SingletonManager protocol
- String .asAttributedString
- String .asInt
- String .asMutableAttributedString
- String .asURL property and specs
- UICollectionView .dequeueFooter(for:)
- UICollectionView .dequeueFooter(_:for:)
- UICollectionView .dequeueHeader(for:)
- UICollectionView .dequeueHeader(_:for:)
- UIPopoverController .present
- UIScrollView .scrollToView(view:animated:)
- UIView .constraintSides(to:)
- UIViewControler .presentInPopoverIfNeeded(_:animated:)
- UIViewController .wrappedIntoPopover

#### Changed
- Moved some fields from Globals to Constants
- Using global class instead of global functions. Globals deprecated.

#### Fixed
- Assure alerts are presented from main thread
- Prevent content adjustment insets if we are specifying insets directly

#### Removed
- Removed appDelegate and rootViewController they should be typecasted by app


## [5.0.1](https://github.com/APUtils/APExtensions/releases/tag/5.0.1)
Released on 12.01.2019.

#### Fixed
- Leak fix for EstimatedRowHeightController


## [5.0.0](https://github.com/APUtils/APExtensions/releases/tag/5.0.0)
Released on 25.10.2018.

#### Added
- Swift 4.2 support
- NSMutableString .set(font:,for:)
- NSMutableString .set(font:aligment:headIndent:lineSpacing:lineHeightMultiple:for:)
- NSMutableString .set(kern:)
- NSMutableString .setUnderline()


#### Fixed
- Swizzling crash if selector doesn't exist.
- Open app settings URL
- UINavigationController completion call


## [4.5.3](https://github.com/APUtils/APExtensions/releases/tag/4.5.3)
Released on 08/02/2018.

#### Added
- Array .random
- Data .asString
- Dictionary .compactMapValues(_:)
- NSObject .doOnce(key:action:)
- Timer .scheduledMinuteStartTimer(action:)
- UIApplication .startBackgroundTaskIfNeeded and .stopBackgroundTaskIfNeeded
- UIScrollView .addRefreshControl(action:)
- UITableView .handleEstimatedSizeAutomatically
- UIViewController .wrappedIntoNavigation
- Utils g_isRunningUnitTests


## [4.5.1](https://github.com/APUtils/APExtensions/releases/tag/4.5.1)
Released on 04/21/2018.

#### Added
- Array .group(_:)
- Array .remove(_:)
- ClassName .className property
- Collection .hasElements
- Data .init(hex:)
- isNilOrEmpty for Optional Arrays and Dictionaries
- String .asUrl
- UITableView .updateCellSizesKeepingContentOffset()
- UIView .becomeFirstResponderIfPossible()
- UIView .isInAnimationClosure

#### Changed
- UITableView .reloadDataKeepingContentOffset() -> .reloadDataKeepingBottomContentOffset()
- Utils g_screenSize struct -> g_screenSize size

#### Fixed
- String .decodedBase64 fix
- UINavigationController .setViewControllers fix


## [4.5.0](https://github.com/APUtils/APExtensions/releases/tag/4.5.0)
Released on 02/23/2018.

#### Added
- ViewState .UIViewControllerViewDidAttached
- UIResponder .becomeFirstResponderWhenPossible
- UIViewController .isBeingAdded
- UIViewController .isBeingTransitioned
- ViewState UIViewControllerViewStateDidChange notification
- ViewState ViewControllerExtendedStates protocol

#### Changed
- UIView .becomeFirstResponderOnViewDidAppear -> UIResponder .becomeFirstResponderOnViewDidAppear
- UIViewContorller+Utils .remove calls endEditing after calling remove methods
- ViewState.didAttached -> didAttach


## [4.4.2](https://github.com/APUtils/APExtensions/releases/tag/4.4.2)
Released on 02/09/2018.

#### Fixed
- g_showPickerAlert crash on iPads


## [4.4.1](https://github.com/APUtils/APExtensions/releases/tag/4.4.1)
Released on 02/09/2018.

#### Added
- AlertController .present(animated:) -> present(animated:completion:)
- AlertController.presentationStyle
- AppearanceCapturerViewController to simplify overlapping window configuration
- Array .dictionaryMap
- Array .enumerateMap
- Array .move(from:to:)
- Array .replaceLast(_:)
- Completion for UIViewController -remove method
- CustomStringConvertible for Optional types
- Delayed value ability to set getValue closure later
- Framework Documentation
- FileManager .directoryExists(at:)
- FileManager .fileExists(at:)
- FileManager .fileExists(url:)
- FileManager .itemExists(at:)
- g_appWindow
- g_getChildrenClasses(of:)
- g_sendEmailUsingMailComposer(to:title:body:attachments:)
- g_sendEmailUsingMailto(to:title:body:)
- g_showEnterTextAlert text:
- g_synchronized(_:,closure:) functon with behaviour of @synchronized
- Instantiatable .storyboardID
- Instantiatable .storyboardName
- NSAttributedString .fullRange
- NSMutableAttributedString .set(font:, for:)
- NSMutableAttributedString .set(font:for:)
- NSMutableAttributedString .set(kern:)
- NSMutableAttributedString .set(lineHeightMultiple:)
- NSMutableAttributedString .set(lineSpacing:)
- Placeholder param for enter text alert
- Rethrows ability for Array and Dictionary helpers
- String .decodedBase64
- String .encodedBase64
- UIBarButtonItem .isHidden
- UIImage .image(withSize:)
- UIImage .init?(contentsOfFile:)
- UINavigationController .pop(viewController:animated:completion:)
- UINavigationController .popToRootViewController(animated:completion:)
- UINavigationController .popViewController()
- UINavigationController .popViewController(animated:completion:)
- UINavigationController .pushViewController(_:)
- UINavigationController .pushViewController(_:animated:completion:)
- UINavigationController .replaceLast(_:animated:completion:)
- UINavigationController .setViewControllers(_:animated:completion:)
- UIScrollView .scrollToBottom(animated:)
- UIScrollView+ViewState .flashScrollIndicatorsOnViewDidAppear
- UIView -hideActivityIndicator force param
- UIView .hideActivityIndicator() do not remove activity indicator from superview
- UIView .isShowingActivityIndicator
- UIView .showActivityIndicator() do not reposition existing one, but brings it to front
- UIViewController .present(_:)
- UIViewController .removeToRoot(animated:completion:)
- UIViewController .rootPresentingViewController
- UIViewController .window
- UIWebView .clear()
- UIWebView .load(url:)
- UIWebView .load(urlString:)
- UIWindow .createAlert()
- URL .fileName
- URL .isImageUrl
- URL .isLocalDirectory
- URL .isLocalFile
- URL .smartAppendingPathComponent(_:isDirectory:)
- Utils ErrorClosure
- Utils GeneralError struct
- Utils g_fileManager
- Utils g_getPointer(_:)
- Utils g_perform(_:) to handle exceptions in Swift
- Utils g_screenScale
- Utils g_tempDirectoryUrl
- ViewConfiguration subspec
- WKWebView .clear()
- WKWebView .load(_ string:)
- WKWebView .load(_ url:)

#### Changed
- Array .remove(_:) -> .remove(_:) -> Element?
- Configurable .configure(model:) -> configure(viewModel:)
- Dequeue and register methods rename for UICollectionView and UITableView
- Dismiss keyboard when removing view controller
- g_fileManager -> g_sharedFileManager
- g_isActive -> g_isAppActive
- g_showErrorAlert - make default action bold
- g_topViewController(base:isCheckPresented:) -> g_topViewController(base:, shouldCheckPresented:)
- Instantiatable (createWithNavigationController() -> UINavigationController) -> (createWithNavigationController() -> (UINavigationController, Self))
- Methods rename to be more swifty. UIViewController .previousViewController -> previous, -removeViewController -> -remove.
- UIApplication .sendEmail(to: String) -> g_sendEmail(to:title:body:)
- UICollectionView .dequeue(for:) -> .dequeueCell(for:)
- UICollectionView .dequeueConfigurableCell(class:for:)
- UICollectionView .dequeueConfigurableFooter(class:for:)
- UICollectionView .dequeueConfigurableHeader(class:for:)
- UICollectionView .registerNib(class:) -> .registerNib(cellClass:)
- UICollectionView .registerNib(footerClass:)
- UICollectionView .registerNib(headerClass:)
- UITableView .dequeueConfigurable(cellClass:indexPath:) -> .dequeueConfigurable(class:for:)
- UIView bigger activity indicator
- UIViewController If controller is not last in navigation stack remove also overlaying controllers
- URLComponents .addQueryItem(_:)

#### Fixed
- Date .gmtDayBeginningDate fix
- DelayedValue preventing self capture in getValue. onValueAvailable won't be called if DelayedValue is deallocated.
- g_statusBarStyleTopViewController improvement
- InstantiatableFromStoryboard possible crash fix
- UIScrollView .clampContentOffset() fix
- UIScrollView also adjust scroll insets when avoiding top or bottom bars
- Warning fixes


## [4.1.1](https://github.com/APUtils/APExtensions/releases/tag/4.1.1)
Released on 09/25/2017.

#### Fixed
- Avoid tab bar getter fix


## [4.1.0](https://github.com/APUtils/APExtensions/releases/tag/4.1.0)
Released on 09/25/2017.

#### Added
- UIScrollView .avoidNavigationBar and .disableAutomaticContentAdjustment

#### Deprecated
- UIScrollView .avoidTopBars


## [4.0.3](https://github.com/APUtils/APExtensions/releases/tag/4.0.3)
Released on 09/22/2017.

#### Changed
- UITableView .dequeueConfigurable(_:) -> .dequeueConfigurable(cellClass:indexPath:)


## [4.0.2](https://github.com/APUtils/APExtensions/releases/tag/4.0.2)
Released on 09/22/2017.

#### Fixed
- UITableView .dequeueConfigurable(_:) fix for Swift 4


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
