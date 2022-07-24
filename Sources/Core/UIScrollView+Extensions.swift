import UIKit
import ObjectiveC

extension UIScrollView {
  private struct AssociatedKeys {
    static var kEmptyBackgroundView = "RBEmptyBackgroundView"
    static var kEmptyDataSource = "RBEmptyDataSource"
    static var kEmptyDelegate = "RBEmptyDelegate"
    static var kContentSizeObserveToken = "RBContentSizeObserveToken"
  }
  
  var emptyBackgroundView: RBEmptyBackgroundView? {
    get {
      if let view = objc_getAssociatedObject(self, &AssociatedKeys.kEmptyBackgroundView) as? RBEmptyBackgroundView {
        return view
      }
      
      let view = RBEmptyBackgroundView(frame: frame)
      view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
      view.isHidden = true
      self.emptyBackgroundView = view
      return view
    }
    set(emptyBackgroundView) {
      objc_setAssociatedObject(self,
                               &AssociatedKeys.kEmptyBackgroundView,
                               emptyBackgroundView,
                               .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
  }
  
  var itemsCount: Int {
    var items = 0
    
    if let tableView = self as? UITableView {
      var sections = 1
      
      if let dataSource = tableView.dataSource {
        if dataSource.responds(to: #selector(UITableViewDataSource.numberOfSections(in:))) {
          sections = dataSource.numberOfSections!(in: tableView)
        }
        if dataSource.responds(to: #selector(UITableViewDataSource.tableView(_:numberOfRowsInSection:))) {
          for i in 0 ..< sections {
            items += dataSource.tableView(tableView, numberOfRowsInSection: i)
          }
        }
      }
    } else if let collectionView = self as? UICollectionView {
      var sections = 1
      
      if let dataSource = collectionView.dataSource {
        if dataSource.responds(to: #selector(UICollectionViewDataSource.numberOfSections(in:))) {
          sections = dataSource.numberOfSections!(in: collectionView)
        }
        if dataSource.responds(to: #selector(UICollectionViewDataSource.collectionView(_:numberOfItemsInSection:))) {
          for i in 0 ..< sections {
            items += dataSource.collectionView(collectionView, numberOfItemsInSection: i)
          }
        }
      }
    }
    
    return items
  }
  
  public var emptyDataSource: RBEmptyDataSource? {
    get {
      let container = objc_getAssociatedObject(self, &AssociatedKeys.kEmptyDataSource) as? WeakObjectContainer
      return container?.weakObject as? RBEmptyDataSource
    }
    set {
      if newValue == nil {
        token?.invalidate()
        token = nil
        hideEmptyView()
      }
      
      objc_setAssociatedObject(self, &AssociatedKeys.kEmptyDataSource, WeakObjectContainer(with: newValue), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
      performObserving()
    }
  }
  
  public var emptyDelegate: RBEmptyDelegate? {
    get {
      let container = objc_getAssociatedObject(self, &AssociatedKeys.kEmptyDelegate) as? WeakObjectContainer
      return container?.weakObject as? RBEmptyDelegate
    }
    set {
      if newValue == nil {
        //              self.invalidate()
      }
      objc_setAssociatedObject(self, &AssociatedKeys.kEmptyDelegate, WeakObjectContainer(with: newValue), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
  }
  
  private var token: NSKeyValueObservation? {
    get {
      return objc_getAssociatedObject(self, &AssociatedKeys.kContentSizeObserveToken) as? NSKeyValueObservation
    }
    set(token) {
      objc_setAssociatedObject(self,
                               &AssociatedKeys.kContentSizeObserveToken,
                               token,
                               .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
  }
  
  private func performObserving() {
    observeContentSize { [weak self] isEmpty in
      guard let self = self else { return }
      isEmpty ? self.showEmptyView() : self.hideEmptyView()
    }
  }
  
  private func observeContentSize(completion: @escaping (Bool) -> Void) {
    token = observe(\.contentSize, options: [.old, .new], changeHandler: {[weak self] scrollView, changed in
      guard let self = self else { return}
      completion(self.itemsCount == 0)
    })
  }
  
  private func showEmptyView() {
    guard emptyDataSource != nil else { return }
    if let view = emptyBackgroundView {
      layoutIfNeeded()
      view.isHidden = false
      view.frame = frame
      if view.superview == nil {
        if (self is UITableView) || (self is UICollectionView) || (subviews.count > 1) {
          insertSubview(view, at: 0)
        } else {
          addSubview(view)
        }
      }
      setView()
    }
    
    isScrollEnabled = false
  }
  
  private func hideEmptyView() {
    if let view = emptyBackgroundView {
      view.isHidden = true
      view.prepareForReuse()
    }
    
    isScrollEnabled = true
  }
  
  private func setView() {
    guard let emptyDataSource = emptyDataSource else { return }
    let topOffset = emptyDataSource.topOffset(self)
    let title = emptyDataSource.title(self)
    let detail = emptyDataSource.detail(self)
    let buttonTitle = emptyDataSource.buttonTitle(self)
    let headerView = emptyDataSource.headerView(self)
    let headerViewSize = emptyDataSource.headerViewSize(self)
    let customView = emptyDataSource.customView(self)
    
    let didTapButton: (UIButton) -> Void = { [weak self] button in
      guard let self = self else { return }
      self.emptyDelegate?.emptyDataSource(self, didTapButton: button)
    }
    
    emptyBackgroundView?.set(customView: customView,
                             topOffset: topOffset,
                             title: title,
                             detail: detail,
                             headerView: headerView,
                             headerViewSize: headerViewSize,
                             buttonTitle: buttonTitle,
                             didTapButton: didTapButton)
  }
}

