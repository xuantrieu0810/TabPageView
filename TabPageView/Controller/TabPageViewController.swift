import UIKit

class TabPageViewController: UIPageViewController {
    /**
     - styleScrollPage
     - pageViewControllers
     - tabPageDelegate
     provided by RootViewController
     */
    var currentIndexPage = 0
    var styleScrollPage: StyleScroll = .standard
    lazy var pageViewControllers: [UIViewController] = []
    var tabPageDelegate: TabPageDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        dataSource = self
        setUpPageView()
    }
    
    func setUpPageView() {
        if currentIndexPage < pageViewControllers.count  {
            scrollToViewController(viewController: pageViewControllers[currentIndexPage])
        }
        tabPageDelegate?.tabPageViewController(tabPageViewController: self, didUpdatePageCount: pageViewControllers.count)
    }
    
    /**
     Scrolls to the view controller at the given index. Automatically calculates the direction.
     - parameter newIndex: the new index to scroll to
     */
    func scrollToViewController(index newIndex: Int) {
        guard newIndex < pageViewControllers.count else {
            return
        }
        if let firstViewController = viewControllers?.first, let currentIndex = pageViewControllers.firstIndex(of: firstViewController) {
            let direction: UIPageViewController.NavigationDirection = newIndex >= currentIndex ? .forward : .reverse
            let nextViewController = pageViewControllers[newIndex]
            scrollToViewController(viewController: nextViewController, direction: direction)
        }
    }
 
    /**
     Scrolls to the given 'viewController' page.
     - parameter viewController: the view controller to show.
     */
    private func scrollToViewController(viewController: UIViewController, direction: UIPageViewController.NavigationDirection = .forward) {
        // step final: set viewcontroller & sent notify
        setViewControllers([viewController], direction: direction, animated: true, completion: { _ in self.notifyTabPageDelegateOfNewIndex() })
    }
    
    /**
     Notifies '_tabPageDelegate' that the current page index was updated.
     */
    private func notifyTabPageDelegateOfNewIndex() {
        if let firstViewController = viewControllers?.first,
           let index = pageViewControllers.firstIndex(of: firstViewController) {
            tabPageDelegate?.tabPageViewController(tabPageViewController: self, didUpdatePageIndex: index)
        }
    }
    
}

// MARK: UIPageViewControllerDataSource

extension TabPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pageViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        let previousIndex = viewControllerIndex - 1
        /// style infinite or normal
        guard previousIndex >= 0 else {
            return styleScrollPage == .infinite ? pageViewControllers.last : nil
        }
        /// check out range
        guard  previousIndex < pageViewControllers.count || previousIndex >= 0 else {
            return nil
        }
        return pageViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pageViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        let nextIndex = viewControllerIndex + 1
        /// style infinire or normal
        guard nextIndex < pageViewControllers.count else {
            return styleScrollPage == .infinite ? pageViewControllers.first : nil
        }
        /// check out range
        guard  nextIndex < pageViewControllers.count || nextIndex >= 0 else {
            return nil
        }
        return pageViewControllers[nextIndex]
    }
    
}

extension TabPageViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        notifyTabPageDelegateOfNewIndex()
    }
}
