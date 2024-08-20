import DesignSystem
import Domain
import SwiftUI

// MARK: - ArtistPage.PlayListComponent

extension ArtistPage {
  struct PlayListComponent {
    let viewState: ViewState
    let tapAction: (MusicEntity.Artist.PlayList.Item) -> Void

    @Environment(\.colorScheme) var colorScheme
  }
}

extension ArtistPage.PlayListComponent { }

// MARK: - ArtistPage.PlayListComponent + View

extension ArtistPage.PlayListComponent: View {
  var body: some View {
    Button(action: { tapAction(viewState.item) }) {
      VStack(alignment: .leading, spacing: 4) {
        RemoteImage(url: viewState.item.artwork.url?.absoluteString ?? "") {
          RoundedRectangle(cornerRadius: 8)
            .fill(.gray.opacity(0.3))
            .frame(width: 180, height: 180)
        }
        .frame(width: 180, height: 180)
        .clipShape(RoundedRectangle(cornerRadius: 8))

        Text(viewState.item.name)
          .font(.footnote)
          .foregroundStyle(
            colorScheme == .dark
              ? DesignSystemColor.system(.white).color
              : DesignSystemColor.system(.black).color)
            .multilineTextAlignment(.leading)
            .lineLimit(1)

        Text(viewState.item.curatorName)
          .font(.footnote)
          .foregroundStyle(DesignSystemColor.palette(.gray(.lv300)).color)
          .lineLimit(1)
      }
    }
  }
}

// MARK: - ArtistPage.PlayListComponent.ViewState

extension ArtistPage.PlayListComponent {
  struct ViewState: Equatable {
    let item: MusicEntity.Artist.PlayList.Item
  }
}
