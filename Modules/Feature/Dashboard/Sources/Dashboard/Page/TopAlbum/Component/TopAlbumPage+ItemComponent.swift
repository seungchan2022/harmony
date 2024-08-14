import ComposableArchitecture
import DesignSystem
import Domain
import SwiftUI

// MARK: - TopAlbumPage.ItemComponent

extension TopAlbumPage {
  struct ItemComponent {
    let viewState: ViewState
    let tapAction: (MusicEntity.Chart.TopAlbum.Item) -> Void

    @Bindable var store: StoreOf<TopAlbumReducer>

    @Environment(\.colorScheme) private var colorScheme

  }
}

extension TopAlbumPage.ItemComponent {
  private var ranking: Int {
    (store.itemList.firstIndex(of: viewState.item) ?? .zero) + 1
  }
}

// MARK: - TopAlbumPage.ItemComponent + View

extension TopAlbumPage.ItemComponent: View {
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

        Text("\(ranking)")
          .font(.title2)
          .fontWeight(.semibold)
          .foregroundStyle(
            colorScheme == .dark
              ? DesignSystemColor.system(.white).color
              : DesignSystemColor.system(.black).color)

        Text(viewState.item.title)
          .font(.body)
          .foregroundStyle(
            colorScheme == .dark
              ? DesignSystemColor.system(.white).color
              : DesignSystemColor.system(.black).color)
            .lineLimit(1)

        Text(viewState.item.artistName)
          .font(.subheadline)
          .foregroundStyle(DesignSystemColor.palette(.gray(.lv300)).color)
          .lineLimit(1)
      }
    }
    .padding(.leading, 12)
  }
}

// MARK: - TopAlbumPage.ItemComponent.ViewState

extension TopAlbumPage.ItemComponent {
  struct ViewState: Equatable {
    let item: MusicEntity.Chart.TopAlbum.Item
  }
}
