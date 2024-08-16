//
//  Model.swift
//  Model
//
//  Created by 박혜운 on 7/21/24.
//

import Foundation

public struct Model: Decodable {
  public var text: String
  var number: Int
  var found: Bool
  var type: String
  
  public init(text: String, number: Int, found: Bool, type: String) {
    self.text = text
    self.number = number
    self.found = found
    self.type = type
  }
}
