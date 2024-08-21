import ComposableArchitecture
import DesignSystem
import Domain
import SwiftUI

// MARK: - HomePage.TopMusicVideoComponent

extension HomePage {
  struct TopMusicVideoComponent {
    let viewState: ViewState

    @Bindable var store: StoreOf<HomeReducer>

    @Environment(\.colorScheme) private var colorScheme

  }
}

extension HomePage.TopMusicVideoComponent {
  private var ranking: Int {
    (store.topMusicVideoItemList.firstIndex(of: viewState.item) ?? .zero) + 1
  }
}

// MARK: - HomePage.TopMusicVideoComponent + View

extension HomePage.TopMusicVideoComponent: View {
  var body: some View {
    Button(action: { }) {
      VStack(alignment: .leading, spacing: 4) {
        RemoteImage(url: viewState.item.artwork.url?.absoluteString ?? "") {
          RoundedRectangle(cornerRadius: 8)
            .fill(.gray.opacity(0.3))
            .frame(width: 180, height: 100)
        }
        .frame(width: 180, height: 100)
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

        Text(viewState.item.artistName)
          .font(.subheadline)
          .foregroundStyle(DesignSystemColor.palette(.gray(.lv300)).color)
      }
    }
    .padding(.leading, 12)
  }
}

// MARK: - HomePage.TopMusicVideoComponent.ViewState

extension HomePage.TopMusicVideoComponent {
  struct ViewState: Equatable {
    let item: MusicEntity.Chart.TopMusicVideo.Item
  }
}
