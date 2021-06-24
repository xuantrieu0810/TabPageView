import UIKit

open class TabPageController: UIViewController {
    
    public static let bundle = Bundle(for: TabPageController.self)
    public static let identifier = "TabPage"
    public static let nameStoryboard = "TabPage"
    @IBOutlet weak var containerTabMenu: UIView!
    @IBOutlet weak var containerTabPage: UIView!
    private var isBackToParent = false
    private var currentIndexMenu = 0
    private var currentIndexPage = 0

    /// PageMenuController data source.
    open weak var dataSource: TabPageControllerDataSource? {
        didSet {
            self.reloadPages()
        }
    }
    /// PageMenuController delegate.
    open weak var delegate: TabPageControllerDelegate?
    /// Current page index
    var currentIndex: Int? {
        didSet {
            currentIndexMenu = currentIndex ?? 0
            currentIndexPage = currentIndex ?? 0
        }
    }
    private var menuTitles = [String]()
    private lazy var viewControllers = [UIViewController]()
    private var tabPageStyle: TabPageStyle?
    private var tabMenuViewController: TabMenuViewController?
    private var tabPageViewController: TabPageViewController?
    
    /**
        #init() #1
     */
    public init?(coder: NSCoder, menuTitles: [String], viewControllers: [UIViewController], tabPageStyle: TabPageStyle) {
        guard menuTitles.count == viewControllers.count else {
            return nil
        }
        super.init(coder: coder)
        self.menuTitles = menuTitles
        self.viewControllers = viewControllers
        self.tabPageStyle = tabPageStyle
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    open override func viewDidLoad() {
        super.viewDidLoad()

        containerTabMenu.addSubview((tabMenuViewController?.view)!)
        containerTabPage.addSubview((tabPageViewController?.view)!)
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        guard !isBackToParent else {
            return
        }
        tabMenuViewController?.scrollToItem(index: currentIndexMenu)
        tabPageViewController?.setViewControllerDefault(indexDefault: currentIndexPage)
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        isBackToParent = true
    }

    /**
     - Get TabPage, TabMenu VỉewController & set properties:
     */
    open override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueTabMenu" {
            if let tabMenu = segue.destination as? TabMenuViewController {
                self.tabMenuViewController = tabMenu
                self.tabMenuViewController?.tabMenuDelegate = self
                self.tabMenuViewController?.tabMenuDataSource = self
                if let tabPageStyle = tabPageStyle {
                    self.tabMenuViewController?.styleMenuTitle = tabPageStyle.styleTabMenu
                }
            }
        }
        else if segue.identifier == "segueTabPage" {
            if let tabPage = segue.destination as? TabPageViewController {
                self.tabPageViewController = tabPage
                self.tabPageViewController?.tabPageDelegate = self
                self.tabPageViewController?.tabPageDataSource = self
                if let tabPageStyle = tabPageStyle {
                    self.tabPageViewController?.styleScrollPage = tabPageStyle.styleTabPage
                }
            }
        }
    }
    
    internal func reloadPages() {
        viewControllers = dataSource?.viewControllers(forTabPageController: self) ?? []
        menuTitles = dataSource?.menuTitles(forTabPageController: self) ?? []
        currentIndex = dataSource?.defaultPageIndex(forTabPageController: self)
    }
    
    // MARK: - Static function go to setting tabpage
    public static func goToSetting(navigationController: UINavigationController!) {
        let vc = UIStoryboard(name: "TabPage", bundle: Bundle(for: SettingTabPageViewController.self)).instantiateViewController(withIdentifier: SettingTabPageViewController.identifier) as? SettingTabPageViewController
        if let vc = vc {
            navigationController.pushViewController(vc, animated: true)
        }
    }
    
}

//MARK: - TabPageDelegate

extension TabPageController: TabPageDelegate, TabMenuDelegate {
    /**
     Called when the number of pages is updated.
     - parameter tabMenuViewController: the tabMenuViewController instance
     - parameter count: the total number of pages.
     */
    func tabMenuViewController(tabMenuViewController: TabMenuViewController,
        didUpdatePageCount count: Int) {
        print("Number of TabMenu: \(count)")
    }
    /**
     Called when the current index is updated.
     - parameter tabMenuViewController: the TabMenuViewController instance
     - parameter index: the index of the currently visible page.
     */
    func tabMenuViewController(tabMenuViewController: TabMenuViewController,
        didUpdatePageIndex index: Int) {
        guard index != currentIndexPage else { return }
        tabPageViewController?.scrollToViewController(index: index)
        currentIndexMenu = index
        currentIndexPage = index
    }
    /**
     Called when the number of pages is updated.
     - parameter tabPageViewController: the tabPageViewController instance
     - parameter count: the total number of pages.
     */
    func tabPageViewController(tabPageViewController: TabPageViewController,
        didUpdatePageCount count: Int) {
        print("Number of PageView: \(count)")
    }
    /**
     Called when the current index is updated.
     - parameter tabPageViewController: the TabPageViewController instance
     - parameter index: the index of the currently visible page.
     */
    func tabPageViewController(tabPageViewController: TabPageViewController,
        didUpdatePageIndex index: Int) {
        guard index != currentIndexMenu else { return }
        tabMenuViewController?.scrollToItem(index: index)
        currentIndexPage = index
        currentIndexMenu = index
    }
}

extension TabPageController: TabMenuDataSource , TabPageDataSource {
    func tabMenuViewController(_ tabMenuViewController: TabMenuViewController, numberOfItemsInTabMenu: Int) -> [String] {
        return menuTitles
    }
    
    func tabMenuViewController(_ tabPageViewController: TabPageViewController, numberOfItemsInTabPage: Int) -> [UIViewController] {
        return viewControllers
    }
}
