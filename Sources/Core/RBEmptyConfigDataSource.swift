import UIKit

public protocol RBEmptyConfigDataSource: AnyObject {
  func title(_ scrollView: UIScrollView, configure: (UILabel) -> Void)
  func detail(_ scrollView: UIScrollView, configure: (UILabel) -> Void)
  func button(_ scrollView: UIScrollView, configure: (UIButton) -> Void)
}

public extension RBEmptyConfigDataSource {
  func title(_ scrollView: UIScrollView, configure: (UILabel) -> Void) { }
  func detail(_ scrollView: UIScrollView, configure: (UILabel) -> Void) { }
  func button(_ scrollView: UIScrollView, configure: (UIButton) -> Void) { }
}
