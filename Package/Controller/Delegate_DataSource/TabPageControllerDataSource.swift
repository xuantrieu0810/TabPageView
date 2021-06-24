
import Foundation
import UIKit

public protocol TabPageControllerDataSource: AnyObject {

    /// The view controllers to display in the page menu view controller.
    func viewControllers(forTabPageController tabPageController: TabPageController) -> [UIViewController]

    /// The view controllers to display in the page menu view controller.
    func menuTitles(forTabPageController tabPageController: TabPageController) -> [String]

    /// The default page index to display in the page menu view controller.
    func defaultPageIndex(forTabPageController tabPageController: TabPageController) -> Int
}
