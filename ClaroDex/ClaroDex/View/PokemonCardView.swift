//
//  PokemonCardView.swift
//  ClaroDex
//
//

import SwiftUI
import SDWebImageSwiftUI

struct PokemonCardView: View {

  typealias localizables = ClaroDexLocalizables

  let padding: CGFloat = 20
  let corner: CGFloat = 10
  let paddingTop: CGFloat = 4
  let wImage: CGFloat = 300
  let hImage: CGFloat = 300
  let leadingImage: CGFloat = 240
  @State var colorBackgorund: Color = .white
  @State var model: BasePokemon = BasePokemon()
  
  var body: some View {
    ZStack {
      VStack(alignment: .leading) {
        Text("\(model.name.capitalized)")
          .font(.title)
          .bold()
          .foregroundColor(Color.white)
          .padding(.top, paddingTop)
          .padding(.leading)
        HStack {
          WebImage(url: URL(string: model.detailPokemon.sprites?.frontDefault ?? ""))
            .resizable()
            .scaledToFit()
            .aspectRatio(contentMode: .fill)
            .frame(width: wImage, height: hImage)
            .overlay(alignment: .bottomTrailing) {
              Text("\(model.detailPokemon.types[.zero].typePokemon.name.capitalized)")
                .font(.title2)
                .foregroundColor(Color.white)
                .padding()
              Text("\(localizables.simbolNumber.localized)\(model.detailPokemon.id)")
                .font(.title3)
                .foregroundColor(Color.white)
                .padding(.leading, -leadingImage)
            }
        }
      }
    }
    .background(colorBackgorund)
    .cornerRadius(corner)
  }
}
struct PokemonCardView_Previews: PreviewProvider {
  static var previews: some View {
    PokemonCardView()
      .padding()
  }
}
