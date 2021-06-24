import Foundation
import UIKit

@objc public protocol TabPageControllerDelegate: AnyObject {

    /// The page view controller will begin scrolling to a new page.
    @objc optional func tabPageController(_ tabPageController: TabPageController, willScrollToPageAtIndex index: Int)

    /// The page view controller scroll progress between pages.
    @objc optional func tabPageController(_ tabPageController: TabPageController, scrollingProgress progress: CGFloat)

    /// The page view controller did complete scroll to a new page.
    @objc optional func tabPageController(_ tabPageController: TabPageController, didScrollToPageAtIndex index: Int)

    /// The menu item of page view controller are selected.
    @objc optional func tabPageController(_ tabPageController: TabPageController, didSelectMenuItem index: Int)
}
