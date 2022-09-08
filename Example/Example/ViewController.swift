import UIKit
import RBEmptyDataSource

class ViewController: UIViewController {

  let tableView = UITableView()
  
  var items: [String] = []
  
  var token: Any?
  var token2: Any?
  
  lazy var button1 = UIBarButtonItem(title: "Shuffle", style: .done, target: self, action:  #selector(click(sender:)))
  lazy var button2 = UIBarButtonItem(title: "Loading", style: .done, target: self, action:  #selector(click2(sender:)))
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.addSubview(tableView)
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    
    navigationItem.setRightBarButtonItems([button1, button2], animated: true)
    
    tableView.eds.setLoading(true)
    tableView.eds.setDataSource(self)
    tableView.eds.setDelegate(self)
  }

  var isLoading = true
  
  @objc func click(sender: Any) {
    let random = Int.random(in: 0...2)
    items = Array(repeating: "Word", count: random)
    tableView.reloadData()
    
  }
  
  @objc func click2(sender: Any) {
    print(isLoading)
    tableView.eds.setLoading(isLoading)
    isLoading.toggle()
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    let safeArea = view.safeAreaLayoutGuide.layoutFrame
    tableView.frame = safeArea
  }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    cell.textLabel?.text = items[indexPath.row]
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 60
  }
}

extension ViewController: RBEmptyDataSource {
  func title(_ scrollView: UIScrollView) -> NSAttributedString? {
    return NSAttributedString(string: "EMPTY DataSource.\nPlease try again")
  }
  
  func detail(_ scrollView: UIScrollView) -> NSAttributedString? {
    return NSAttributedString(string: "EMPTY DataSource.\nPlease try again uoi alls.\nEMPTY DataSource.\nPlease try again oi alls.")
  }
  
  func headerView(_ scrollView: UIScrollView) -> UIView? {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "img")
    return imageView
  }
  
  func headerViewSize(_ scrollView: UIScrollView) -> CGSize {
    return CGSize(width: 300, height: 300)
  }

//  func customView(_ scrollView: UIScrollView) -> UIView? {
//    let view = UIView()
//    view.backgroundColor = UIColor.green.withAlphaComponent(0.4)
//    return view
//  }
  
  func buttonTitle(_ scrollView: UIScrollView) -> NSAttributedString? {
    return NSAttributedString(string: "Click me!", attributes: [
      .foregroundColor: UIColor.red
    ])
  }
  
  func buttonTitle(_ scrollView: UIScrollView, for state: UIControl.State) -> NSAttributedString? {
    switch state {
    case .normal:
      return NSAttributedString(string: "Click me!", attributes: [
        .foregroundColor: UIColor.red
      ])
    case .highlighted:
      return NSAttributedString(string: "Click me!", attributes: [
        .foregroundColor: UIColor.blue
      ])
    default:
      return nil
    }
  }
  
  func topOffset(_ scrollView: UIScrollView) -> CGFloat {
    return 32
  }
  
  func spacing(_ scrollView: UIScrollView) -> CGFloat {
    return 16
  }
  
  func loadingTitle(_ scrollView: UIScrollView) -> NSAttributedString? {
    return NSAttributedString(string: "LOADING...")
  }
  
  func loadingCustomView(_ scrollView: UIScrollView) -> UIView? {
    let view = ActivityView()
    let indicator = UIActivityIndicatorView()
    view.addSubview(indicator)
    indicator.translatesAutoresizingMaskIntoConstraints = false
    indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    indicator.topAnchor.constraint(equalTo: view.topAnchor, constant: 32).isActive = true
    indicator.heightAnchor.constraint(greaterThanOrEqualToConstant: 48).isActive = true
    indicator.widthAnchor.constraint(greaterThanOrEqualToConstant: 48).isActive = true
    
    indicator.startAnimating()
    return view
  }
}

extension ViewController: RBEmptyDelegate {
  func emptyDataSource(_ scrollView: UIScrollView, didTapButton button: UIButton) {
    print("TAPPED")
  }
  
  func emptyDataSourceWillAppear(_ scrollView: UIScrollView) {
    print(#function)
  }
  
  func emptyDataSourceWillDisappear(_ scrollView: UIScrollView) {
    print(#function)
  }
}


class ActivityView: UIView {
  deinit {
    print("SUKA")
  }
}
