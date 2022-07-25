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
  
  lazy var headerContainerView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
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
  
  func set(customView: UIView?,
           topOffset: CGFloat = 32,
           title: NSAttributedString?,
           detail: NSAttributedString?,
           headerView: UIView?,
           headerViewSize: CGSize = .zero,
           buttonTitle: NSAttributedString?,
           buttonHighlightedTitle: NSAttributedString?,
           spacing: CGFloat = 8,
           didTapButton: ((UIButton) -> ())?) {
    if let customView = customView {
      addSubview(customView)
      customView.translatesAutoresizingMaskIntoConstraints = false
      customView.topAnchor.constraint(equalTo: topAnchor, constant: topOffset).isActive = true
      customView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
      customView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
      customView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
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
      
      if let headerView = headerView {
        headerContainerView.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.topAnchor.constraint(
          equalTo: headerContainerView.topAnchor,
          constant: topOffset).isActive = true
        headerView.leadingAnchor.constraint(
          equalTo: headerContainerView.leadingAnchor,
          constant: 0).isActive = true
        headerView.trailingAnchor.constraint(
          equalTo: headerContainerView.trailingAnchor,
          constant: 0).isActive = true
        headerView.bottomAnchor.constraint(
          equalTo: headerContainerView.bottomAnchor,
          constant: 0).isActive = true
      }
      
      contentView.spacing = spacing
      headerContainerView.isHidden = headerView == nil
      
      headerContainerView.heightAnchor.constraint(equalToConstant: headerViewSize.height).isActive = true
      headerContainerView.widthAnchor.constraint(equalToConstant: headerViewSize.width).isActive = true
      
        addSubview(contentView)
      contentView.topAnchor.constraint(equalTo: topAnchor, constant: topOffset).isActive = true
      contentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
      contentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
      contentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
      
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
      
    }
    
    layoutIfNeeded()
  }
  
  func prepareForReuse() {
    subviews.forEach {
      $0.removeFromSuperview()
    }
    
      titleLabel.attributedText = nil
      titleLabel.isHidden = true
      
      detailLabel.attributedText = nil
      detailLabel.isHidden = true
      
      button.setTitle(nil, for: .normal)
      button.isHidden = true
      
    headerContainerView.subviews.forEach {
      $0.removeFromSuperview()
    }
    
    didTapButton = nil
    
  }
  
  @objc private func buttonClicked(sender: UIButton) {
    didTapButton?(sender)
  }
}
