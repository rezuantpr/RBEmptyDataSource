import Foundation

class WeakObjectContainer: NSObject {
  weak var weakObject: AnyObject?
  
  init(with weakObject: Any?) {
    super.init()
    self.weakObject = weakObject as AnyObject?
  }
}
