import DesignSystem
import Domain
import SwiftUI

// MARK: - SearchPage.AlbumComponent

extension SearchPage {
  struct AlbumComponent {
    let viewState: ViewState
    let tapAcion: (MusicEntity.Search.Album.Item) -> Void

    @Environment(\.colorScheme) private var colorScheme
  }
}

extension SearchPage.AlbumComponent { }

// MARK: - SearchPage.AlbumComponent + View

extension SearchPage.AlbumComponent: View {
  var body: some View {
    Button(action: { tapAcion(viewState.item) }) {
      VStack(alignment: .leading) {
        HStack(spacing: 12) {
          RemoteImage(url: viewState.item.artwork.url?.absoluteString ?? "") {
            RoundedRectangle(cornerRadius: 8)
              .fill(.gray.opacity(0.3))
              .frame(width: 60, height: 60)
          }
          .clipShape(RoundedRectangle(cornerRadius: 8))
          .frame(width: 60, height: 60)

          VStack(alignment: .leading, spacing: 4) {
            Text(viewState.item.title)
              .font(.body)
              .foregroundStyle(
                colorScheme == .dark
                  ? DesignSystemColor.system(.white).color
                  : DesignSystemColor.system(.black).color)

            Text("앨범 • \(viewState.item.artistName)")
              .font(.subheadline)
              .foregroundStyle(DesignSystemColor.palette(.gray(.lv300)).color)
          }
          .multilineTextAlignment(.leading)
          .lineLimit(1)

          Spacer()

          Image(systemName: "chevron.right")
            .foregroundStyle(DesignSystemColor.palette(.gray(.lv400)).color)
        }
        .padding(.horizontal, 12)

        Divider()
          .padding(.leading, 76)
      }
    }
  }
}

// MARK: - SearchPage.AlbumComponent.ViewState

extension SearchPage.AlbumComponent {
  struct ViewState: Equatable {
    let item: MusicEntity.Search.Album.Item
  }
}
