import ComposableArchitecture
import DesignSystem
import Domain
import SwiftUI

// MARK: - ArtistPage.FullAlbumComponent

extension ArtistPage {
  struct FullAlbumComponent {
    let viewState: ViewState

    @Environment(\.colorScheme) private var colorScheme

  }
}

extension ArtistPage.FullAlbumComponent { }

// MARK: - ArtistPage.FullAlbumComponent + View

extension ArtistPage.FullAlbumComponent: View {
  var body: some View {
    Button(action: { }) {
      VStack(alignment: .leading, spacing: 4) {
        RemoteImage(url: viewState.item.artwork.url?.absoluteString ?? "") {
          RoundedRectangle(cornerRadius: 8)
            .fill(.gray.opacity(0.3))
            .frame(width: 180, height: 180)
        }
        .frame(width: 180, height: 180)
        .clipShape(RoundedRectangle(cornerRadius: 8))

        Text(viewState.item.title)
          .font(.footnote)
          .foregroundStyle(
            colorScheme == .dark
              ? DesignSystemColor.system(.white).color
              : DesignSystemColor.system(.black).color)
            .multilineTextAlignment(.leading)
            .lineLimit(1)

        Text("\(viewState.item.releaseDate.formatted(.dateTime.year(.defaultDigits)))년")
          .font(.footnote)
          .foregroundStyle(DesignSystemColor.palette(.gray(.lv300)).color)
          .lineLimit(1)
      }
    }
    .padding(.leading, 12)
  }
}

// MARK: - ArtistPage.FullAlbumComponent.ViewState

extension ArtistPage.FullAlbumComponent {
  struct ViewState: Equatable {
    let item: MusicEntity.Artist.FullAlbum.Item
  }
}
