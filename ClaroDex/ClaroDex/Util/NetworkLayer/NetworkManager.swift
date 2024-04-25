//
//  NetworkManager.swift
//  ClaroDex
//
//  Created by Mugrosito on 24/04/24.
//

import Foundation

class NetworkManager {
  
  init(){ }

  func executeAsync<T: Decodable>(url: String) async -> Result<T, FetchError> {
    guard let url = URL(string: url) else {
      return .failure(.badURL)
    }
    do {
      let (data, response) = try await URLSession.shared.data(from: url)
      
      guard let httpResponse = response as? HTTPURLResponse,
            httpResponse.statusCode == 200 else {
        return .failure(.responseError)
      }
      
      let model = try JSONDecoder().decode(T.self, from: data)
      return .success(model)
    } catch {
      return .failure(.badCast)
    }
  }
}
