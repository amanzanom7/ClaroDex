//
//  PokemonDetailView.swift
//  ClaroDex
//
//  Created by Mugrosito on 24/04/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct PokemonDetailView: View {

  typealias localizables = ClaroDexLocalizables
  
  let model: ViewModel
  let pokemon: BasePokemon
  var delegate: DetailViewDelegate?
  var typePokemon: String {
    return pokemon.detailPokemon.types[.zero].typePokemon.name.capitalized
  }

  let paddignWebImage: CGFloat = 20
  let paddignText: CGFloat = 8
  let wImage: CGFloat = 200
  let hImage: CGFloat = 400
  let hScrollView: CGFloat = 40
  let sizeImageShiny: CGFloat = 170
  let leadingStat: CGFloat = 7
  let opacity: CGFloat = 0.6
  let lineSpacing: CGFloat = 8.0
  
  @Environment(\.presentationMode) var presentationMode

  var body: some View {
    ZStack {
      Color(model.backgroundColorPokemon(forType: pokemon.detailPokemon))
      ScrollView {
        Spacer()
          .frame(height: hScrollView)
        WebImage(url: URL(string: pokemon.detailPokemon.sprites?.frontDefault ?? ""))
          .resizable()
          .scaledToFit()
          .aspectRatio(contentMode: .fill)
          .frame(width: wImage, height: hImage)
          .padding(.leading, paddignWebImage)
          .padding(.trailing, paddignWebImage)
          .padding(.top, paddignWebImage)
        VStack(alignment: .leading) {
          Text("\(localizables.simbolNumber.localized)\(pokemon.detailPokemon.id) - \(pokemon.name.capitalized)")
            .font(.title2)
            .padding(.leading, .zero)
            .navigationTitle(localizables.titleNavDetail.localized)
          Text(localizables.feature.localized)
            .fontWeight(.light)
            .padding(.vertical, paddignText)
          HStack {
            Text(localizables.titleTypeDetail.localized)
              .fontWeight(.light)
              .opacity(opacity)
            Text(" \(typePokemon)")
              .fontWeight(.medium)
              .foregroundColor( Color(model.backgroundColorPokemon(forType: pokemon.detailPokemon)))
              .padding(.leading, -leadingStat)
              .onTapGesture {
                delegate?.didDismissPokemonDetailView(with: typePokemon)
                presentationMode.wrappedValue.dismiss()
              }
          }
          HStack(alignment: .top) {
            VStack(alignment: .leading) {
              HStack {
                Text(localizables.titleTypeSpeedDetail.localized)
                  .fontWeight(.light)
                  .opacity(opacity)
                Text(" \(model.detailStatPokemon.speed)")
                  .fontWeight(.medium)
                  .padding(.leading, -leadingStat)
              }
              HStack {
                Text(localizables.titleTypeDefenseDetail.localized)
                  .fontWeight(.light)
                  .opacity(opacity)
                Text(" \(model.detailStatPokemon.defense)")
                  .fontWeight(.medium)
                  .padding(.leading, -leadingStat)
              }
              HStack {
                Text(localizables.titleTypeDesense2Detail.localized)
                  .fontWeight(.light)
                  .opacity(opacity)
                Text(" \(model.detailStatPokemon.defenseSpecial)")
                  .fontWeight(.medium)
                  .padding(.leading, -leadingStat)
              }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
          }
          .padding(.vertical )
        }
        .padding()
        .padding(.top)
        .background(.white)
        .cornerView(radius: 30, corners: [.topLeft, .topRight])
        .offset(x: .zero, y: .zero)
        .overlay(alignment: .bottomTrailing) {
          WebImage(url: URL(string: pokemon.detailPokemon.sprites?.frontShiny ?? ""))
            .resizable()
            .scaledToFit()
            .frame(width: sizeImageShiny, height: sizeImageShiny)
            .padding(.leading, hScrollView)
            .padding(.trailing, .zero)
            .padding(.top, paddignWebImage)
            .overlay(alignment: .top)  {
              Text("\(localizables.titleShinyDetail.localized) \(pokemon.name)")
                .lineSpacing(lineSpacing)
                .fontWeight(.medium)
                .foregroundColor( Color(model.backgroundColorPokemon(forType: pokemon.detailPokemon)))
                .padding(.leading)
            }
        }
      }
    }
    .onAppear() {
      model.getStatPokemon(forType: pokemon.detailPokemon.stats)
    }
  }
}

extension View {
  func cornerView(radius: CGFloat,
                  corners: UIRectCorner) -> some View {
    clipShape(RoundedCorner(radius: radius,
                            corners: corners))
  }
}

struct PokemonDetailView_Previews: PreviewProvider {
  static var previews: some View {
    PokemonDetailView(model: ViewModel(), pokemon: BasePokemon())
      .environmentObject(ViewModel())
  }
}
