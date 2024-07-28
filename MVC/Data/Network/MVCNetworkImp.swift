//
//  MVCNetworkImp.swift
//  MVCNetworkImp
//
//  Created by 박혜운 on 7/21/24.
//

import Foundation
import Model
import MVCNetwork

public struct MVCNetworkImp: MVCNetwork {
  public init() { }
  
  public func fetchData(from num: String) async -> Model? {
    guard let url = URL(string: "http://numbersapi.com/\(num)?json") else { return nil }
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    
    do {
      let (data, response) = try await URLSession.shared.data(for: request)
      guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else { return nil }
      let model = try? JSONDecoder().decode(Model.self, from: data)
      return model
      
    } catch {
      print(error.localizedDescription)
      return nil
    }
  }
}
