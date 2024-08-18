import DesignSystem
import Domain
import SwiftUI

// MARK: - SearchPage.ArtistComponent

extension SearchPage {
  struct ArtistComponent {
    let viewState: ViewState
    let tapAction: (MusicEntity.Search.Artist.Item) -> Void

    @Environment(\.colorScheme) private var colorScheme

  }
}

extension SearchPage.ArtistComponent { }

// MARK: - SearchPage.ArtistComponent + View

extension SearchPage.ArtistComponent: View {
  var body: some View {
    Button(action: { tapAction(viewState.item) }) {
      VStack(alignment: .leading) {
        HStack(spacing: 12) {
          RemoteImage(url: viewState.item.artwork.url?.absoluteString ?? "") {
            Circle()
              .fill(.gray.opacity(0.3))
              .frame(width: 60, height: 60)
              .overlay {
                Image(systemName: "music.mic.circle.fill")
                  .resizable()
                  .frame(width: 60, height: 60)
                  .foregroundStyle(.thickMaterial)
              }
          }
          .frame(width: 60, height: 60)
          .clipShape(Circle())

          VStack(alignment: .leading, spacing: 4) {
            Text(viewState.item.name)
              .font(.body)
              .foregroundStyle(
                colorScheme == .dark
                  ? DesignSystemColor.system(.white).color
                  : DesignSystemColor.system(.black).color)

            Text("아티스트")
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

// MARK: - SearchPage.ArtistComponent.ViewState

extension SearchPage.ArtistComponent {
  struct ViewState: Equatable {
    let item: MusicEntity.Search.Artist.Item
  }
}
