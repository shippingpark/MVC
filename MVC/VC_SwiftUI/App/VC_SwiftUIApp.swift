//
//  VC_SwiftUIApp.swift
//  VC_SwiftUI
//
//  Created by 박혜운 on 7/21/24.
//

import SwiftUI
import MVCNetworkImp

@main
struct VC_SwiftUIApp: App {
  var body: some Scene {
    WindowGroup {
      let network = MVCNetworkImp()
      let controller = Controller(network: network)
      ContentView(controller: controller)
    }
  }
}
