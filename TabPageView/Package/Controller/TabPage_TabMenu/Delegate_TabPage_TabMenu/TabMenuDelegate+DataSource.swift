protocol TabMenuDelegate: AnyObject {
    
    /**
     Called when the number of pages is updated.
     - parameter tabMenuViewController: the tabMenuViewController instance
     - parameter count: the total number of pages.
     */
    func tabMenuViewController(tabMenuViewController: TabMenuViewController,
        didUpdatePageCount count: Int)
    
    /**
     Called when the current index is updated.
     
     - parameter tabMenuViewController: the TabMenuViewController instance
     - parameter index: the index of the currently visible page.
     */
    func tabMenuViewController(tabMenuViewController: TabMenuViewController,
        didUpdatePageIndex index: Int)
    
}

protocol TabMenuDataSource: AnyObject {
    func tabMenuViewController(_ tabMenuViewController: TabMenuViewController, numberOfItemsInTabMenu: Int) -> [String]
    
}
