import DesignSystem
import Domain
import SwiftUI

// MARK: - FullAlbumPage.ItemComponent

extension FullAlbumPage {
  struct ItemComponent {
    let viewState: ViewState

    @Environment(\.colorScheme) private var colorScheme

  }
}

extension FullAlbumPage.ItemComponent { }

// MARK: - FullAlbumPage.ItemComponent + View

extension FullAlbumPage.ItemComponent: View {
  var body: some View {
    Button(action: { }) {
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

// MARK: - FullAlbumPage.ItemComponent.ViewState

extension FullAlbumPage.ItemComponent {
  struct ViewState: Equatable {
    let item: MusicEntity.Album.FullAlbum.Item
  }
}
