//
//  ViewController.swift
//  VC_UIKit
//
//  Created by 박혜운 on 7/23/24.
//

import UIKit
import Model
import MVCNetwork

class ViewController: UIViewController {
  var network: MVCNetwork?
  
  private lazy var infoLabel: UILabel = {
    let label = UILabel()
    label.text = "..."
    label.font = .preferredFont(forTextStyle: .headline)
    label.textColor = .darkGray
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .center
    label.numberOfLines = 0
    return label
  }()
  
  private lazy var textField: UITextField = {
    let textField = UITextField()
    textField.placeholder = "Enter text"
    textField.borderStyle = .roundedRect
    textField.translatesAutoresizingMaskIntoConstraints = false
    return textField
  }()
  
  private lazy var confirmButton: UIButton = {
    let button = UIButton()
    button.setTitle("확인", for: .normal)
    button.titleLabel?.font = .preferredFont(forTextStyle: .body)
    button.setTitleColor(.black, for: .normal)
    button.backgroundColor = .lightGray
    button.translatesAutoresizingMaskIntoConstraints = false
    button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    self.configureSubviews()
    self.configureUI()
  }
  
  private func configureSubviews() {
    self.view.addSubview(self.confirmButton)
    self.view.addSubview(self.textField)
    self.view.addSubview(self.infoLabel)
  }
  
  private func configureUI() {
    NSLayoutConstraint.activate([
      confirmButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      confirmButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      confirmButton.widthAnchor.constraint(equalToConstant: 200),
      confirmButton.heightAnchor.constraint(equalToConstant: 50),
      
      textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      textField.bottomAnchor.constraint(equalTo: confirmButton.topAnchor, constant: -20),
      textField.widthAnchor.constraint(equalToConstant: 200),
      textField.heightAnchor.constraint(equalToConstant: 40),
      
      infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      infoLabel.bottomAnchor.constraint(equalTo: textField.topAnchor, constant: -20),
      infoLabel.widthAnchor.constraint(equalToConstant: 300),
      infoLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 30)
    ])
  }
  
  @objc func buttonTapped() {
    guard let input = textField.text else { return }
    
    self.infoLabel.text = "로딩중..."
    
    Task {
      guard let model = await network?.fetchData(from: input) else {
        self.infoLabel.text = "다운 실패"
        return
      }
      DispatchQueue.main.async { [weak self] in
        self?.infoLabel.text = model.text
      }
    }
  }
}

