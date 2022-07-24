import UIKit

public protocol RBEmptyDelegate: AnyObject {
  func emptyDataSource(_ scrollView: UIScrollView, didTapButton button: UIButton)
}

public extension RBEmptyDelegate {
  func emptyDataSource(_ scrollView: UIScrollView, didTapButton button: UIButton) { }
}
