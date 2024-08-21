import DesignSystem
import Domain
import SwiftUI

// MARK: - SimilarArtistPage.ItemComponent

extension SimilarArtistPage {
  struct ItemComponent {
    let viewState: ViewState
    let tapAction: (MusicEntity.Artist.SimilarArtist.Item) -> Void

    @Environment(\.colorScheme) private var colorScheme
  }
}

extension SimilarArtistPage.ItemComponent { }

// MARK: - SimilarArtistPage.ItemComponent + View

extension SimilarArtistPage.ItemComponent: View {
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
          .clipShape(Circle())
          .frame(width: 60, height: 60)

          Text(viewState.item.name)
            .font(.body)
            .foregroundStyle(
              colorScheme == .dark
                ? DesignSystemColor.system(.white).color
                : DesignSystemColor.system(.black).color)

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

// MARK: - SimilarArtistPage.ItemComponent.ViewState

extension SimilarArtistPage.ItemComponent {
  struct ViewState: Equatable {
    let item: MusicEntity.Artist.SimilarArtist.Item
  }
}
