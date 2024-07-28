//
//  MVCNetwork.swift
//  MVCNetwork
//
//  Created by 박혜운 on 7/21/24.
//

import Model

public protocol MVCNetwork {
  func fetchData(from num: String) async -> Model?
}
