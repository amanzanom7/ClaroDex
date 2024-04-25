//
//  ViewModel.swift
//  ClaroDex
//
//  Created by Mugrosito on 24/04/24.
//

import Foundation
import SwiftUI

@MainActor
class ViewModel: ObservableObject {

  @Published var pokemonBase: ResponseList = ResponseList()
  @Published var filterPokemon: ResponseList = ResponseList()
  @Published var detailStatPokemon: DetailTypeStat = DetailTypeStat()
  @Published var searchElement: String = ""

  let network: NetworkManager = NetworkManager()

  func executeAsync(_ page: Int) {
      Task {
        let url: String = "https://pokeapi.co/api/v2/pokemon?offset=\(String(page))&limit=20"
        let result:Result<ResponseList, FetchError> = await network.executeAsync(url: url)
        switch result {
        case .success(let modelo):
          var customPokemonList: [BasePokemon] = []
          var asignIndex: BasePokemon = BasePokemon()
          for pokemon in modelo.results {
            let url: String = pokemon.url
            let result: Result<DetailPokemon, FetchError> = await network.executeAsync(url: url)
            switch result {
            case .success(let modelo):
              asignIndex.detailPokemon = modelo
              asignIndex.name = pokemon.name
              customPokemonList.append(asignIndex)
            case .failure(let error):
              print(error.localizedDescription)
            }
          }
          if pokemonBase.results.isEmpty {
            pokemonBase.results = customPokemonList
          } else {
            pokemonBase.results.append(contentsOf: customPokemonList)
          }
          filterPokemon = pokemonBase
        case .failure(let error):
          print(error.localizedDescription)
        }
      }
  }

  func filterListPokemon(_ search: String)  {
    if search.isEmpty {
      filterPokemon = pokemonBase
    } else {      
      let nameFilteredResults = pokemonBase.results.filter { $0.name.localizedCaseInsensitiveContains(search) || 
        $0.detailPokemon.types[.zero].typePokemon.name.localizedCaseInsensitiveContains(search) ||
        String($0.detailPokemon.id).localizedCaseInsensitiveContains(search) }

      let combinedResults = Array(Set(nameFilteredResults))
      
      filterPokemon.results = combinedResults
    }
  }

  func addPaginator(_ paginator: Int) -> Int {
    let sumPaginator = paginator + 20
    return sumPaginator
  }

  func backgroundColorPokemon(forType type: DetailPokemon) -> Color {
    let findColor = type.types.count > .zero ? type.types[.zero].typePokemon.name : ""
    switch findColor {
      case "fire": return Color.red
      case "grass": return Color.green
      case "water": return Color.blue
      case "electric": return Color.yellow
      case "psychic", "poison": return Color.purple
      case "normal": return Color.orange
      case "ground": return Color.gray
      case "flying": return Color.teal
      case "fairy": return Color.pink
      default:
        return Color.indigo
    }
  }
  
  func getStatPokemon(forType stats: [StatsPokemon]) {
    var speed: String = ""
    var defense: String = ""
    var defenseSpecial: String = ""
    stats.forEach { statsPokemon in
      switch statsPokemon.statPokemon.name.lowercased() {
      case "speed": speed = String(statsPokemon.baseStat)
      case "special-defense": defenseSpecial = String(statsPokemon.baseStat)
      case "defense": defense = String(statsPokemon.baseStat)
      default:
        return
      }
    }
    detailStatPokemon = DetailTypeStat(speed: speed, defense: defense, defenseSpecial: defenseSpecial)
  }
}
