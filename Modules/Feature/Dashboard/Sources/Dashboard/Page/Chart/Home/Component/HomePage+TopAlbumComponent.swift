import ComposableArchitecture
import DesignSystem
import Domain
import SwiftUI

// MARK: - HomePage.TopAlbumComponent

extension HomePage {
  struct TopAlbumComponent {
    let viewState: ViewState
    let tapAction: (MusicEntity.Chart.TopAlbum.Item) -> Void

    @Bindable var store: StoreOf<HomeReducer>

    @Environment(\.colorScheme) private var colorScheme

  }
}

extension HomePage.TopAlbumComponent {
  private var ranking: Int {
    (store.topAlbumItemList.firstIndex(of: viewState.item) ?? .zero) + 1
  }
}

// MARK: - HomePage.TopAlbumComponent + View

extension HomePage.TopAlbumComponent: View {
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

        Text(viewState.item.artistName)
          .font(.subheadline)
          .foregroundStyle(DesignSystemColor.palette(.gray(.lv300)).color)
      }
    }
    .padding(.leading, 12)
  }
}

// MARK: - HomePage.TopAlbumComponent.ViewState

extension HomePage.TopAlbumComponent {
  struct ViewState: Equatable {
    let item: MusicEntity.Chart.TopAlbum.Item
  }
}
