//
//  Managers.swift
//  ClaroDex
//
//  Created by Mugrosito on 25/04/24.
//
import Foundation

protocol DetailViewDelegate {
  func didDismissPokemonDetailView(with type: String)
}

enum ResponseAccess {
  case success(DetailPokemon)
  case failure(FetchError)
}

enum FetchError: Error {
  case badURL
  case badCast
  case responseError
  case serverError
}

enum ClaroDexLocalizables: String {
  case titleNav = "titleNav"
  case titleSearch = "titleSearch"
  case simbolNumber = "simbolNumber"
  case titleNavDetail = "titleNavDetail"
  case feature = "feature"
  case titleTypeDetail = "titleTypeDetail"
  case titleTypeSpeedDetail = "titleTypeSpeedDetail"
  case titleTypeDefenseDetail = "titleTypeDefenseDetail"
  case titleTypeDesense2Detail = "titleTypeDesense2Detail"
  case titleShinyDetail = "titleShinyDetail"
  
  var localized: String { return self.rawValue.claroLocalizable  }
}

extension String {
  public var claroLocalizable: String {
    return NSLocalizedString(self, tableName: "Localizable", bundle: Bundle.main, comment: "")
  }
}
