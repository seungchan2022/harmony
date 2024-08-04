import ComposableArchitecture
import DesignSystem
import Domain
import SwiftUI

// MARK: - TopPlayListPage.ItemComponent

extension TopPlayListPage {
  struct ItemComponent {
    let viewState: ViewState

    @Bindable var store: StoreOf<TopPlayListReducer>

    @Environment(\.colorScheme) private var colorScheme

  }
}

extension TopPlayListPage.ItemComponent {
  private var ranking: Int {
    (store.itemList.firstIndex(of: viewState.item) ?? .zero) + 1
  }
}

// MARK: - TopPlayListPage.ItemComponent + View

extension TopPlayListPage.ItemComponent: View {
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
            .lineLimit(1)

        Text(viewState.item.curatorName)
          .font(.subheadline)
          .foregroundStyle(DesignSystemColor.palette(.gray(.lv300)).color)
          .lineLimit(1)
      }
    }
    .padding(.leading, 12)
  }
}

// MARK: - TopPlayListPage.ItemComponent.ViewState

extension TopPlayListPage.ItemComponent {
  struct ViewState: Equatable {
    let item: MusicEntity.Chart.TopPlayList.Item
  }
}
