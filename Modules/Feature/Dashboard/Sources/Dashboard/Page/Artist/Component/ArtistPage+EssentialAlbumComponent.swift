import ComposableArchitecture
import DesignSystem
import Domain
import SwiftUI

// MARK: - ArtistPage.EssentialAlbumComponent

extension ArtistPage {
  struct EssentialAlbumComponent {
    let viewState: ViewState
    let tapAction: () -> Void

    @Environment(\.colorScheme) private var colorScheme
  }
}

extension ArtistPage.EssentialAlbumComponent { }

// MARK: - ArtistPage.EssentialAlbumComponent + View

extension ArtistPage.EssentialAlbumComponent: View {
  var body: some View {
    VStack {
      RemoteImage(url: viewState.item.artwork.url?.absoluteString ?? "") {
        RoundedRectangle(cornerRadius: 8)
          .fill(.gray.opacity(0.3))
          .frame(width: 320, height: 320)
      }
      .frame(width: 320, height: 320)
      .clipShape(RoundedRectangle(cornerRadius: 8))

      Text(viewState.item.title)
        .font(.footnote)
        .fontWeight(.light)
        .foregroundStyle(
          colorScheme == .dark
            ? DesignSystemColor.system(.white).color
            : DesignSystemColor.system(.black).color)
          .multilineTextAlignment(.leading)
          .lineLimit(1)
//      HStack {
//
//
//
//        Spacer()
//      }
//      .padding(.leading, 16)
    }
    .onTapGesture {
      tapAction()
    }
  }
}

// MARK: - ArtistPage.EssentialAlbumComponent.ViewState

extension ArtistPage.EssentialAlbumComponent {
  struct ViewState: Equatable {
    let item: MusicEntity.Artist.EssentialAlbum.Item
  }
}
