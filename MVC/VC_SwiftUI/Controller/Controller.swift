//
//  Controller.swift
//  VC_SwiftUI
//
//  Created by 박혜운 on 7/23/24.
//

import SwiftUI
import MVCNetwork

// MARK: - Input: User Action
// Controller가 더 이상 View에 가까운 일 (업데이트 사항을 전달해 주는 일 / Input을 넣어주는 일 / Update)
// 을 하지 않기 때문에 Controller를 자신의 Delegate(대리)로 보는 표현이 어색함.
// 소유 관계에 따라 자신(View)의 Delegate가 아닌 Controller의 Interface로 명칭 변경. (주관적 생각)
// 해당 역할(ControllerInterface)은 UIKit에서 MainViewDelegate였음
protocol ControllerInterface: ObservableObject {
  func confirmButtonTapped(with input: String)
  func updateTextField(input: String)
  var textFieldContent: String { get }
  var infoLabelContent: String { get }
  // View가 Controller에 직접 접근하여 데이터를 읽는다는 점도 UIKit과 다름
  // UIKit에서는 View가 자기 자신 위에 올라갈 정보의 출처를 모름
}

class Controller: ObservableObject, ControllerInterface {
  @Published var textFieldContent: String = ""
  @Published var infoLabelContent: String = "..."
  private var network: MVCNetwork
  
  init(network: MVCNetwork) {
    self.network = network
  }
  
  func confirmButtonTapped(with input: String) {
    guard !textFieldContent.isEmpty else {
      updateLabel(content: "입력 없음")
      return
    }
    updateLabel(content: "로딩 중")
    fetchData(input: textFieldContent)
  }
  
  private func fetchData(input: String) {
    Task {
      if let model = await network.fetchData(from: input) {
        DispatchQueue.main.async {
          self.updateLabel(content: model.text) // Update가 메서드가 View가 아닌 데이터를 향함
        }
      } else {
        DispatchQueue.main.async {
          self.updateLabel(content: "다운 실패")
        }
      }
    }
  }
  
  func updateTextField(input: String) {
    textFieldContent = input
  }
  
  private func updateLabel(content: String) {
    infoLabelContent = content
  }
}
