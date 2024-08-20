import ComposableArchitecture
import DesignSystem
import Domain
import SwiftUI

// MARK: - HomePage.TopPlayListComponent

extension HomePage {
  struct TopPlayListComponent {
    let viewState: ViewState
    let tapAction: (MusicEntity.Chart.TopPlayList.Item) -> Void

    @Bindable var store: StoreOf<HomeReducer>

    @Environment(\.colorScheme) private var colorScheme

  }
}

extension HomePage.TopPlayListComponent {
  private var ranking: Int {
    (store.topPlayItemList.firstIndex(of: viewState.item) ?? .zero) + 1
  }
}

// MARK: - HomePage.TopPlayListComponent + View

extension HomePage.TopPlayListComponent: View {
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

        Text(viewState.item.name)
          .font(.body)
          .foregroundStyle(
            colorScheme == .dark
              ? DesignSystemColor.system(.white).color
              : DesignSystemColor.system(.black).color)

        Text(viewState.item.curatorName)
          .font(.subheadline)
          .foregroundStyle(DesignSystemColor.palette(.gray(.lv300)).color)
      }
    }
    .padding(.leading, 12)
  }
}

// MARK: - HomePage.TopPlayListComponent.ViewState

extension HomePage.TopPlayListComponent {
  struct ViewState: Equatable {
    let item: MusicEntity.Chart.TopPlayList.Item
  }
}
