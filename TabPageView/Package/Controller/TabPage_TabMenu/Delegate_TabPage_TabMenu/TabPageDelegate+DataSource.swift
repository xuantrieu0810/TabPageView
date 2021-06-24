import UIKit

protocol TabPageDelegate: AnyObject {
    
    /**
     Called when the number of pages is updated.
     - parameter tabPageViewController: the tabPageViewController instance
     - parameter count: the total number of pages.
     */
    func tabPageViewController(tabPageViewController: TabPageViewController,
        didUpdatePageCount count: Int)
    
    /**
     Called when the current index is updated.
     
     - parameter tabPageViewController: the TabPageViewController instance
     - parameter index: the index of the currently visible page.
     */
    func tabPageViewController(tabPageViewController: TabPageViewController,
        didUpdatePageIndex index: Int)
    
}

protocol TabPageDataSource: AnyObject {
    func tabMenuViewController(_ tabPageViewController: TabPageViewController, numberOfItemsInTabPage: Int) -> [UIViewController]
    
}
