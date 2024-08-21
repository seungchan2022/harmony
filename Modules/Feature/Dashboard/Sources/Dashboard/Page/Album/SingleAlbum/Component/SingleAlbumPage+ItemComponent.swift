import DesignSystem
import Domain
import SwiftUI

// MARK: - SingleAlbumPage.ItemComponent

extension SingleAlbumPage {
  struct ItemComponent {
    let viewState: ViewState
    let tapAction: (MusicEntity.Album.SingleAlbum.Item) -> Void

    @Environment(\.colorScheme) private var colorScheme

  }
}

extension SingleAlbumPage.ItemComponent { }

// MARK: - SingleAlbumPage.ItemComponent + View

extension SingleAlbumPage.ItemComponent: View {
  var body: some View {
    Button(action: { tapAction(viewState.item) }) {
      VStack(alignment: .leading, spacing: 4) {
        RemoteImage(url: viewState.item.artwork.url?.absoluteString ?? "") {
          RoundedRectangle(cornerRadius: 8)
            .fill(.gray.opacity(0.3))
            .frame(width: 180, height: 180)
        }
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .frame(width: 180, height: 180)

        Text(viewState.item.title)
          .font(.body)
          .foregroundStyle(
            colorScheme == .dark
              ? DesignSystemColor.system(.white).color
              : DesignSystemColor.system(.black).color)
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

// MARK: - SingleAlbumPage.ItemComponent.ViewState

extension SingleAlbumPage.ItemComponent {
  struct ViewState: Equatable {
    let item: MusicEntity.Album.SingleAlbum.Item
  }
}
