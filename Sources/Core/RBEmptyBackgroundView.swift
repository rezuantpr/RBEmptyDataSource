import UIKit

class RBEmptyBackgroundView: UIView {
  lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 27.0)
    label.textColor = UIColor(white: 0.6, alpha: 1.0)
    label.textAlignment = .center
    label.lineBreakMode = .byWordWrapping
    label.numberOfLines = 0
    return label
  }()
  
  lazy var detailLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 17.0)
    label.textColor = UIColor(white: 0.6, alpha: 1.0)
    label.textAlignment = .center
    label.lineBreakMode = .byWordWrapping
    label.numberOfLines = 0
    return label
  }()
  
  lazy var button: UIButton = {
    let button = UIButton(type: .custom)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.backgroundColor = .clear
    button.contentHorizontalAlignment = .center
    button.contentVerticalAlignment = .center
    button.addTarget(self, action: #selector(buttonClicked(sender:)), for: .touchUpInside)
    return button
  }()
  
  lazy var headerContainerView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.alignment = .fill
    stackView.distribution = .fill
  
    return stackView
  }()
  
  lazy var customViewContainer: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.alignment = .fill
    stackView.distribution = .fill
  
    return stackView
  }()
    
  lazy var contentView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [headerContainerView, titleLabel, detailLabel, button])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.alignment = .center
    stackView.distribution = .fill
    stackView.spacing = 8
    
    let spacer = UIView()
    spacer.backgroundColor = .clear
    stackView.addArrangedSubview(spacer)
    return stackView
  }()
  
  private var didTapButton: ((UIButton) -> ())?
  
  var topOffset: CGFloat = 32
  var headerViewSize: CGSize = .zero
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    addSubview(contentView)
    addSubview(customViewContainer)
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    addSubview(contentView)
    addSubview(customViewContainer)
  }
  
  func set(customView: UIView? = nil,
           topOffset: CGFloat = 32,
           title: NSAttributedString? = nil,
           detail: NSAttributedString? = nil,
           headerView: UIView? = nil,
           headerViewSize: CGSize = .zero,
           buttonTitle: NSAttributedString? = nil,
           buttonHighlightedTitle: NSAttributedString? = nil,
           spacing: CGFloat = 8,
           didTapButton: ((UIButton) -> ())? = nil,
           isLoading: Bool = false,
           loadingTitle: NSAttributedString? = nil,
           customLoadingView: UIView? = nil) {
    self.topOffset = topOffset
    self.headerViewSize = headerViewSize
    
    if isLoading {
      if let customView = customLoadingView {
        customViewContainer.arrangedSubviews.forEach { $0.removeFromSuperview() }
        customViewContainer.addArrangedSubview(customView)
        customViewContainer.alpha = 1
      } else {
        titleLabel.attributedText = loadingTitle
        titleLabel.isHidden = loadingTitle == nil
        
        detailLabel.isHidden = true
        button.isHidden = true
      }
      return ()
    }
    if let customView = customView {
      customViewContainer.arrangedSubviews.forEach { $0.removeFromSuperview() }
      customViewContainer.addArrangedSubview(customView)
      customViewContainer.alpha = 1
    } else {
      self.didTapButton = didTapButton
      titleLabel.attributedText = title
      titleLabel.isHidden = title == nil
      
      detailLabel.attributedText = detail
      detailLabel.isHidden = detail == nil
      
      button.setAttributedTitle(buttonTitle, for: .normal)
      let highlightedTitle = buttonHighlightedTitle ?? buttonTitle
      button.setAttributedTitle(highlightedTitle, for: .highlighted)
      button.isHidden = buttonTitle == nil
      
      headerContainerView.arrangedSubviews.forEach { $0.removeFromSuperview() }
      if let headerView = headerView {
        headerContainerView.addArrangedSubview(headerView)
      }
      
      contentView.spacing = spacing
      headerContainerView.isHidden = headerView == nil
      
    }
    
    layoutIfNeeded()
    setNeedsUpdateConstraints()
  }
  
  func prepareForReuse() {
      titleLabel.attributedText = nil
      titleLabel.isHidden = true
      
      detailLabel.attributedText = nil
      detailLabel.isHidden = true
      
      button.setTitle(nil, for: .normal)
      button.isHidden = true
        
    headerContainerView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    customViewContainer.arrangedSubviews.forEach { $0.removeFromSuperview()}
    didTapButton = nil
    
    topOffset = .zero
    headerViewSize = .zero
    customViewContainer.alpha = 0
  }
  
  override func updateConstraints() {
    headerContainerView.heightAnchor.constraint(equalToConstant: headerViewSize.height).isActive = true
    headerContainerView.widthAnchor.constraint(equalToConstant: headerViewSize.width).isActive = true
    
    contentView.topAnchor.constraint(equalTo: topAnchor,
                                     constant: topOffset).isActive = true
    contentView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                         constant: 0).isActive = true
    contentView.trailingAnchor.constraint(equalTo: trailingAnchor,
                                          constant: 0).isActive = true
    contentView.bottomAnchor.constraint(equalTo: bottomAnchor,
                                        constant: 0).isActive = true
    
    titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                        constant: 16).isActive = true
    titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                         constant: -16).isActive = true
    detailLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                         constant: 16).isActive = true
    detailLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                         constant: -16).isActive = true
    button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                         constant: 16).isActive = true
    button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                         constant: -16).isActive = true
    
    customViewContainer.topAnchor.constraint(equalTo: topAnchor,
                                             constant: topOffset).isActive = true
    customViewContainer.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                 constant: 0).isActive = true
    customViewContainer.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                  constant: 0).isActive = true
    customViewContainer.bottomAnchor.constraint(equalTo: bottomAnchor,
                                                constant: 0).isActive = true
    
    
    super.updateConstraints()
  }
  
  @objc private func buttonClicked(sender: UIButton) {
    didTapButton?(sender)
  }
}
