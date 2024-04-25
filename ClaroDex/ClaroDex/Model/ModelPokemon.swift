//
//  DetailPokemon.swift
//  ClaroDex
//
//  Created by Mugrosito on 24/04/24.
//

import Foundation
import SwiftUI

struct ResponseList: Hashable, Decodable {
  var results: [BasePokemon] = []
  
  enum CodingKeys: CodingKey {
    case results
  }
}

struct BasePokemon: Hashable, Decodable {
  var name: String = ""
  var url: String = ""
  var detailPokemon: DetailPokemon = DetailPokemon()

  enum CodingKeys: CodingKey {
    case name
    case url
  }
}

struct DetailPokemon: Hashable, Decodable {
  var id: Int = 0
  var sprites: SpritesPokemon?
  var types: [TypesPokemon] = []
  var stats: [StatsPokemon] = []

  init() { }

  enum CodingKeys: String, CodingKey {
    case id
    case sprites
    case types
    case stats
  }
}

struct SpritesPokemon: Hashable, Decodable {
  var frontDefault: String = ""
  var frontShiny: String = ""
  

  init() { }

  enum CodingKeys: String, CodingKey {
    case frontDefault = "front_default"
    case frontShiny = "front_shiny"
  }
}

struct TypesPokemon: Hashable, Decodable {
  var typePokemon: BaseType = BaseType()

  init() { }

  enum CodingKeys: String, CodingKey {
    case typePokemon = "type"
  }
}
struct StatsPokemon: Hashable, Decodable {
  var baseStat: Int = 0
  var statPokemon: TypeStat = TypeStat()
  
  init() { }
  
  enum CodingKeys: String, CodingKey {
    case baseStat = "base_stat"
   case statPokemon = "stat"
  }
}

struct BaseType: Hashable, Decodable {
  var name: String = ""

  init() { }

  enum CodingKeys: String, CodingKey {
    case name
  }
}
struct TypeStat: Hashable, Decodable {
  var name: String = ""

  init() { }

  enum CodingKeys: String, CodingKey {
    case name
  }
}

struct DetailTypeStat {
  var speed: String = ""
  var defense: String = ""
  var defenseSpecial: String = ""
}

struct RoundedCorner: Shape {
  var radius: CGFloat = .infinity
  var corners: UIRectCorner = .allCorners

  func path(in rect: CGRect) -> Path {
    let path = UIBezierPath(roundedRect: rect,
                            byRoundingCorners: corners,
                            cornerRadii: CGSize(width: radius, height: radius))
    return Path(path.cgPath)
  }
}
