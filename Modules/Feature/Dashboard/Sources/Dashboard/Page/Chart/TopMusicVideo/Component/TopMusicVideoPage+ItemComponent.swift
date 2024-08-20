import ComposableArchitecture
import DesignSystem
import Domain
import SwiftUI

// MARK: - TopMusicVideoPage.ItemComponent

extension TopMusicVideoPage {
  struct ItemComponent {
    let viewState: ViewState

    @Bindable var store: StoreOf<TopMusicVideoReducer>

    @Environment(\.colorScheme) private var colorScheme

  }
}

extension TopMusicVideoPage.ItemComponent {
  private var ranking: Int {
    (store.itemList.firstIndex(of: viewState.item) ?? .zero) + 1
  }
}

// MARK: - TopMusicVideoPage.ItemComponent + View

extension TopMusicVideoPage.ItemComponent: View {
  var body: some View {
    Button(action: { }) {
      VStack(alignment: .leading, spacing: 4) {
        RemoteImage(url: viewState.item.artwork.url?.absoluteString ?? "") {
          RoundedRectangle(cornerRadius: 8)
            .fill(.gray.opacity(0.3))
            .frame(width: 180, height: 100)
        }
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .frame(width: 180, height: 100)

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

// MARK: - TopMusicVideoPage.ItemComponent.ViewState

extension TopMusicVideoPage.ItemComponent {
  struct ViewState: Equatable {
    let item: MusicEntity.Chart.TopMusicVideo.Item
  }
}
