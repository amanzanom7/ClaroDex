//
//  ContentView.swift
//  ClaroDex
//
//  Created by Mugrosito on 23/04/24.
//

import SwiftUI

struct ContentView: View {

  typealias localizables = ClaroDexLocalizables

  @State private var canLoadMore = false
  @State private var paginator: Int = .zero
  @StateObject var model = ViewModel()

  let lineSpacingLazyHStack: CGFloat = 15
  let wProgressView: CGFloat = 350
  let hProgressView: CGFloat = 150
  let sizeProgressView: CGFloat = 100
  let opacity: CGFloat = 0.2

  var areDataLoaded: Bool {
    !model.pokemonBase.results.isEmpty
  }
  
  var body: some View {
    NavigationView {
      VStack {
        ScrollView(.horizontal, showsIndicators: false) {
          LazyHStack(spacing: lineSpacingLazyHStack) {
            if !areDataLoaded {
              ProgressView()
                .frame(width: wProgressView, height: hProgressView)
            } else {
              ForEach(model.filterPokemon.results, id: \.self) { item in
                NavigationLink(destination: PokemonDetailView(model: model, pokemon: item, delegate: self)) {
                  PokemonCardView(colorBackgorund: model.backgroundColorPokemon(forType: item.detailPokemon), model: item)
                }
                .onAppear {
                  if model.pokemonBase.results.indices.last == model.pokemonBase.results.firstIndex(of: item) {
                    loadMoreItems()
                  }
                }
              }
              if canLoadMore {
                ProgressView()
                  .frame(width: sizeProgressView, height: sizeProgressView)
              }
            }
          }
          .padding()
          .navigationTitle(localizables.titleNav.localized)
          .navigationBarTitleDisplayMode(.inline)
        }
        .searchable(text: $model.searchElement , placement: .navigationBarDrawer(displayMode: .always), prompt: localizables.titleSearch.localized)
        .onChange(of: model.searchElement, { oldValue, newValue in
          withAnimation {
            model.filterListPokemon(newValue)
          }
        })
        .background(Color.gray.opacity(opacity))
      }
    }
    .onAppear() {
      paginator = .zero
      model.executeAsync(paginator)
    }
  }
  
  func loadMoreItems() {
    canLoadMore = true
    paginator = model.addPaginator(paginator)
    model.executeAsync(paginator)
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      canLoadMore = false
    }
  }
}

extension ContentView: DetailViewDelegate {
  func didDismissPokemonDetailView(with type: String) {
    model.searchElement = type
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
