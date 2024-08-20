import DesignSystem
import Domain
import SwiftUI

// MARK: - ArtistPage.SimilarArtistComponent

extension ArtistPage {
  struct SimilarArtistComponent {
    let viewState: ViewState
    let tapAction: (MusicEntity.Artist.SimilarArtist.Item) -> Void

    @Environment(\.colorScheme) var colorScheme
  }
}

extension ArtistPage.SimilarArtistComponent { }

// MARK: - ArtistPage.SimilarArtistComponent + View

extension ArtistPage.SimilarArtistComponent: View {
  var body: some View {
    Button(action: { tapAction(viewState.item) }) {
      VStack(alignment: .center, spacing: 4) {
        RemoteImage(url: viewState.item.artwork.url?.absoluteString ?? "") {
          Circle()
            .fill(.gray.opacity(0.3))
            .frame(width: 120, height: 120)
        }
        .frame(width: 120, height: 120)
        .clipShape(Circle())

        Text(viewState.item.name)
          .font(.footnote)
          .foregroundStyle(
            colorScheme == .dark
              ? DesignSystemColor.system(.white).color
              : DesignSystemColor.system(.black).color)
            .lineLimit(1)
      }
    }
  }
}

// MARK: - ArtistPage.SimilarArtistComponent.ViewState

extension ArtistPage.SimilarArtistComponent {
  struct ViewState: Equatable {
    let item: MusicEntity.Artist.SimilarArtist.Item
  }
}
