//
//  ContentView.swift
//  VC_SwiftUI
//
//  Created by 박혜운 on 7/21/24.
//

import SwiftUI
import Model
import MVCNetwork

// MARK: - View는 변화에 대한 정보를 모름 

// MARK: - SwiftUI에서는 View가 Controller 구독!
// Controller가 View를 알아야 하는 일이 사라짐 (양방향 바인딩 가능)
// 구독을 위해 View가 Controller를 소유하는 형태
// (그러니 SwiftUI에서는) 자연스럽게 Controller에서 View에게 Input을 넣어주는 역할이 소멸
// 즉 View에게 적절한 Model을 입력해 주는 View+Controller로서의 권한이 약화되고 (자동으로 이루어지고)
// Model을 적절한 형태로 가공하는 ModelController로서의 권한이 두드러짐 (역할 상 ViewModel)

struct ContentView<Controller: ControllerInterface>: View {
  @ObservedObject var controller: Controller
  
  var body: some View {
    VStack {
      Text(controller.infoLabelContent)
        .font(.headline)
        .multilineTextAlignment(.center)
        .padding()
      
      TextField(
        "Enter text", 
        text: .init(
          get: { controller.textFieldContent },
          set: { controller.updateTextField(input: $0) }
        )
      )
      .textFieldStyle(RoundedBorderTextFieldStyle())
      .padding()
      
      Button(action: {
        controller.confirmButtonTapped(with: controller.textFieldContent)
      }) {
        Text("확인")
          .font(.body)
          .foregroundColor(.black)
          .padding()
          .background(Color.gray.opacity(0.5))
          .cornerRadius(5)
      }
      .padding()
    }
    .padding()
  }
}
