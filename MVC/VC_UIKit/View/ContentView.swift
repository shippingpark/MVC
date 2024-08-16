//
//  View.swift
//  VC_UIKit
//
//  Created by 박혜운 on 7/23/24.
//

import UIKit

// MARK: - View는 변화에 대한 정보를 모름 

// MARK: - Output: User Action
protocol ContentViewDelegate: AnyObject {
  func confirmButtonTapped(with input: String?)
}

// MARK: - Input: Update
protocol ContentViewInterface: UIView {
  /// delegate는 action을 내보낼 창구.
  /// 엄밀히는 View 기준 Input과 무관하고 Output과 관련 있으나 Output 연결에 필수적이므로 작성 요구
  var delegate: ContentViewDelegate? { get set }
  func updateInfoLabelWith(_ text: String)
}

class ContentView: UIView {
  weak var delegate: ContentViewDelegate?
  
  let infoLabel: UILabel = {
    let label = UILabel()
    label.text = "..."
    label.font = .preferredFont(forTextStyle: .headline)
    label.textColor = .darkGray
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .center
    label.numberOfLines = 0
    return label
  }()
  
  let textField: UITextField = {
    let textField = UITextField()
    textField.placeholder = "Enter text"
    textField.borderStyle = .roundedRect
    textField.translatesAutoresizingMaskIntoConstraints = false
    return textField
  }()
  
  let confirmButton: UIButton = {
    let button = UIButton()
    button.setTitle("확인", for: .normal)
    button.titleLabel?.font = .preferredFont(forTextStyle: .body)
    button.setTitleColor(.black, for: .normal)
    button.backgroundColor = .lightGray
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = .white
    configureSubviews()
    configureUI()
    addActionTargets()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configureSubviews() {
    self.addSubview(self.confirmButton)
    self.addSubview(self.textField)
    self.addSubview(self.infoLabel)
  }
  
  private func configureUI() {
    NSLayoutConstraint.activate([
      confirmButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      confirmButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      confirmButton.widthAnchor.constraint(equalToConstant: 200),
      confirmButton.heightAnchor.constraint(equalToConstant: 50),
      
      textField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      textField.bottomAnchor.constraint(equalTo: confirmButton.topAnchor, constant: -20),
      textField.widthAnchor.constraint(equalToConstant: 200),
      textField.heightAnchor.constraint(equalToConstant: 40),
      
      infoLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      infoLabel.bottomAnchor.constraint(equalTo: textField.topAnchor, constant: -20),
      infoLabel.widthAnchor.constraint(equalToConstant: 300),
      infoLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 30)
    ])
  }
  
  private func addActionTargets() {
    confirmButton.addTarget(self, action: #selector(confirmButtonAction), for: .touchUpInside)
  }

  // MARK: - Output: User Action
  @objc private func confirmButtonAction() {
      delegate?.confirmButtonTapped(with: textField.text) // Controller에게 전달
  }
  
  // MARK: - Methods
  private func updateInfoLabel(with text: String) {
    infoLabel.text = text
  }
}

// MARK: - Update
extension ContentView: ContentViewInterface {
  public func updateInfoLabelWith(_ text: String) {
    updateInfoLabel(with: text)
  }
}

