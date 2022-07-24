import UIKit

public protocol RBExtensionsProvider: AnyObject {
  associatedtype CompatibleType
  var eds: CompatibleType { get }
}

extension RBExtensionsProvider {
  public var eds: EDS<Self> {
    return EDS(self)
  }
}

public struct EDS<Base> {
  public let base: Base
  fileprivate init(_ base: Base) {
    self.base = base
  }
}

extension UIScrollView: RBExtensionsProvider { }

public extension EDS where Base: UIScrollView {
  func setDataSource(_ dataSource: RBEmptyDataSource?) {
    base.emptyDataSource = dataSource
  }
  
  func setDelegate(_ delegate: RBEmptyDelegate?) {
    base.emptyDelegate = delegate
  }
  
  func reloadData() {
    base.hideEmptyView()
    base.showEmptyView()
  }
}

