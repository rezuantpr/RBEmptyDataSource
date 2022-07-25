import UIKit

public protocol RBEmptyDelegate: AnyObject {
  func emptyDataSource(_ scrollView: UIScrollView, didTapButton button: UIButton)
  func emptyDataSourceWillAppear(_ scrollView: UIScrollView)
  func emptyDataSourceWillDisappear(_ scrollView: UIScrollView)
}

public extension RBEmptyDelegate {
  func emptyDataSource(_ scrollView: UIScrollView, didTapButton button: UIButton) { }
  func emptyDataSourceWillAppear(_ scrollView: UIScrollView) { }
  func emptyDataSourceWillDisappear(_ scrollView: UIScrollView) { }
}
