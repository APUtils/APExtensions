//
//  UIView+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 28/05/16.
//  Copyright © 2019 Anton Plebanovich. All rights reserved.
//

import UIKit

// ******************************* MARK: - Screen related

public extension UIView {
    
    /// Consider view with alpha <0.01 as invisible because it stops receiving touches at this level:
    /// "This method ignores view objects that are hidden, that have disabled user interactions, or have an alpha level less than 0.01".
    /// This one also checks all superviews for the same parameters.
    var isVisible: Bool {
        return ([self] + superviews).allSatisfy { !$0.isHidden && $0.alpha >= 0.01 }
    }
    
    /// Checks wheter view is visible in containing window.
    var isVisibleInWindow: Bool {
        guard let window = window else { return false }
        let viewFrameInWindow = convert(bounds, to: window)
        return window.bounds.intersects(viewFrameInWindow)
    }
}

// ******************************* MARK: - Sizes

public extension UIView {
    /// View width
    var width: CGFloat {
        get {
            return bounds.width
        }
        set {
            bounds.size.width = newValue
        }
    }
    
    /// View height
    var height: CGFloat {
        get {
            return bounds.height
        }
        set {
            bounds.size.height = newValue
        }
    }
    
    /// View size
    var size: CGSize {
        get {
            return bounds.size
        }
        set {
            bounds.size = newValue
        }
    }
}

// ******************************* MARK: - Animations

public extension UIView {
    
    /// Checks if code runs inside animation closure
    @available(iOS 9.0, *)
    static var isInAnimationClosure: Bool {
        return inheritedAnimationDuration > 0
    }
    
    /// Returns `true` if view can be animated.
    /// That means `window` is not `nil` and application state is `.active`.
    var isAnimatable: Bool {
        return window != nil && UIApplication.shared.applicationState == .active
    }
    
    func fadeInAnimated() {
        guard alpha != 1 else { return }
        
        g.animate { self.alpha = 1 }
    }
    
    func fadeOutAnimated() {
        guard alpha != 0 else { return }
        
        g.animate { self.alpha = 0 }
    }
}

// ******************************* MARK: - Utils

public extension UIView {
    /// Makes corner radius euqal to half of width or height
    func makeRound() {
        layer.cornerRadius = min(width, height) / 2
    }
    
    /// Returns closest UIViewController from responders chain.
    var viewController: UIViewController? {
        var nextResponder: UIResponder? = self
        while nextResponder != nil {
            nextResponder = nextResponder?.next
            
            if let viewController = nextResponder as? UIViewController {
                return viewController
            }
        }
        
        return nil
    }
    
    /// Gets view's top most superview
    var rootView: UIView {
        return superview?.rootView ?? self
    }
}

// ******************************* MARK: - Sequence

public extension UIView {
    
    /// Returns all view's subviews
    var allSubviews: [UIView] {
        var allSubviews = self.subviews
        allSubviews.forEach { allSubviews.append(contentsOf: $0.allSubviews) }
        return allSubviews
    }
    
    /// Returns all view's subviews
    var allVisibleSubviews: [UIView] {
        var allSubviewsVisible = self.subviews
        allSubviewsVisible
            .filter { $0.isVisible }
            .forEach { allSubviewsVisible.append(contentsOf: $0.allVisibleSubviews) }
        
        return allSubviewsVisible
    }
    
    #if compiler(>=5)
    /// All view superviews to the top most
    var superviews: DropFirstSequence<UnfoldSequence<UIView, (UIView?, Bool)>> {
        return sequence(first: self, next: { $0.superview }).dropFirst(1)
    }
    #else
    /// All view superviews to the top most
    var superviews: AnySequence<UIView> {
        return sequence(first: self, next: { $0.superview }).dropFirst(1)
    }
    #endif
}

// ******************************* MARK: - Image

public extension UIView {
    /// Creates image from view and adds overlay image at the center if provided
    func getSnapshotImage() -> UIImage? {
        if #available(iOS 10.0, *) {
            let renderer = UIGraphicsImageRenderer(bounds: bounds)
            return renderer.image { rendererContext in
                layer.render(in: rendererContext.cgContext)
            }
            
        } else {
            UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0)
            defer { UIGraphicsEndImageContext() }
            guard let context = UIGraphicsGetCurrentContext() else { return nil }
            self.layer.render(in: context)
            guard let snapshotImage = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
            return snapshotImage
        }
    }
}

// ******************************* MARK: - Responder Helpers

public extension UIView {
    /// Ends editing on view and all of it's subviews
    @IBAction func endEditing() {
        endEditing(true)
    }
    
    /// Checks if window is not nil before calling becomeFirstResponder()
    func becomeFirstResponderIfPossible() {
        guard window != nil else { return }
        
        becomeFirstResponder()
    }
}

// ******************************* MARK: - Activity Indicator

private var showCounterKey = 0

public extension UIView {
    private var showCounter: Int {
        get {
            return (objc_getAssociatedObject(self, &showCounterKey) as? Int) ?? 0
        }
        set {
            objc_setAssociatedObject(self, &showCounterKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// Is activity indicator showing?
    var isShowingActivityIndicator: Bool {
        return showCounter > 0
    }
    
    /// Shows activity indicator.
    /// It uses existing one if found in subviews.
    /// Calls to -showActivityIndicator and -hideActivityIndicator have to be balanced or hide have to be forced.
    func showActivityIndicator() {
        showCounter += 1
        
        var activityIndicator: UIActivityIndicatorView! = subviews.compactMap({ $0 as? UIActivityIndicatorView }).last
        if activityIndicator == nil {
            activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
            activityIndicator.color = .lightGray
            addSubview(activityIndicator)
            activityIndicator.center = CGPoint(x: bounds.midX, y: bounds.midY)
            activityIndicator.autoresizingMask = [.flexibleTopMargin, .flexibleLeftMargin, .flexibleRightMargin, .flexibleBottomMargin]
        }
        activityIndicator.superview?.bringSubviewToFront(activityIndicator)
        
        if !activityIndicator.isAnimating {
            activityIndicator.startAnimating()
        }
    }
    
    /// Hides activity indicator.
    /// Calls to -showActivityIndicator and -hideActivityIndicator have to be balanced or hide have to be forced.
    /// - parameters:
    ///   - force: Force activity indicator hide
    func hideActivityIndicator(force: Bool = false) {
        if force {
            showCounter = 0
        } else {
            showCounter -= 1
        }
        
        if showCounter <= 0 {
            let activityIndicator = subviews.compactMap({ $0 as? UIActivityIndicatorView }).first
            activityIndicator?.stopAnimating()
            
            showCounter = 0
        }
    }
}

// ******************************* MARK: - Constraints

public extension UIView {
    /// Creates constraints between self and provided view for top, bottom, leading and trailing sides.
    @available(iOS 9.0, *)
    func constraintSides(to view: UIView) {
        let constraints: [NSLayoutConstraint] = [
            bottomAnchor.constraint(equalTo: view.bottomAnchor),
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topAnchor.constraint(equalTo: view.topAnchor)
        ]
        
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints)
    }
}
