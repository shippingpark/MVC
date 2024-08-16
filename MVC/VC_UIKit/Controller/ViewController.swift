//
//  ViewController.swift
//  VC_UIKit
//
//  Created by 박혜운 on 7/23/24.
//

import UIKit
import Model
import MVCNetwork

class ViewController: UIViewController, ContentViewDelegate {
  private var network: MVCNetwork
  private var mainView: ContentViewInterface
  
  init(view: ContentViewInterface, network: MVCNetwork) {
    self.mainView = view
    self.network = network
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func loadView() {
    self.view = mainView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    mainView.delegate = self
  }
  
  func confirmButtonTapped(with input: String?) {
    guard let input else { mainView.updateInfoLabelWith("입력 없음"); return }
    mainView.updateInfoLabelWith("로딩 중")
    Task {
      if let model = await network.fetchData(from: input) {
        DispatchQueue.main.async { [weak self] in
          self?.mainView.updateInfoLabelWith(model.text)
        }
      } else {
        DispatchQueue.main.async { [weak self] in
          self?.mainView.updateInfoLabelWith("다운 실패")
        }
      }
    }
  }
}

