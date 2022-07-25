import UIKit

public protocol RBEmptyDataSource: AnyObject {
  func topOffset(_ scrollView: UIScrollView) -> CGFloat
  func title(_ scrollView: UIScrollView) -> NSAttributedString?
  func detail(_ scrollView: UIScrollView) -> NSAttributedString?
  func buttonTitle(_ scrollView: UIScrollView, for state: UIControl.State) -> NSAttributedString?
  func headerView(_ scrollView: UIScrollView) -> UIView?
  func headerViewSize(_ scrollView: UIScrollView) -> CGSize
  func customView(_ scrollView: UIScrollView) -> UIView?
  func spacing(_ scrollView: UIScrollView) -> CGFloat
}

public extension RBEmptyDataSource {
  func topOffset(_ scrollView: UIScrollView) -> CGFloat { 32 }
  func title(_ scrollView: UIScrollView) -> NSAttributedString? { nil }
  func detail(_ scrollView: UIScrollView) -> NSAttributedString? { nil }
  func buttonTitle(_ scrollView: UIScrollView, for state: UIControl.State) -> NSAttributedString? { nil }
  func headerView(_ scrollView: UIScrollView) -> UIView? { nil }
  func headerViewSize(_ scrollView: UIScrollView) -> CGSize { CGSize(width: 200, height: 200)}
  func customView(_ scrollView: UIScrollView) -> UIView? { nil }
  func spacing(_ scrollView: UIScrollView) -> CGFloat { 8 }
}
