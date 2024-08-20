import ComposableArchitecture
import DesignSystem
import Domain
import SwiftUI

// MARK: - HomePage.MostPlayedSongComponent

extension HomePage {
  struct MostPlayedSongComponent {
    let viewState: ViewState

    @Bindable var store: StoreOf<HomeReducer>

    @Environment(\.colorScheme) private var colorScheme

  }
}

extension HomePage.MostPlayedSongComponent {
  private var ranking: Int {
    (store.mostPlayedSongItemList.firstIndex(of: viewState.item) ?? .zero) + 1
  }
}

// MARK: - HomePage.MostPlayedSongComponent + View

extension HomePage.MostPlayedSongComponent: View {
  var body: some View {
    Button(action: { }) {
      VStack {
        Divider()
          .padding(.leading, 72)

        HStack(spacing: 12) {
          RemoteImage(url: viewState.item.artwork.url?.absoluteString ?? "") {
            RoundedRectangle(cornerRadius: 8)
              .fill(.gray.opacity(0.3))
              .frame(width: 60, height: 60)
          }
          .frame(width: 60, height: 60)
          .clipShape(RoundedRectangle(cornerRadius: 8))

          Text("\(ranking)")
            .font(.title3)
            .fontWeight(.semibold)
            .foregroundStyle(
              colorScheme == .dark
                ? DesignSystemColor.system(.white).color
                : DesignSystemColor.system(.black).color)

          VStack(alignment: .leading, spacing: 4) {
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

          Spacer()

          Image(systemName: "ellipsis")
            .fontWeight(.bold)
            .foregroundStyle(
              colorScheme == .dark
                ? DesignSystemColor.system(.white).color
                : DesignSystemColor.system(.black).color)
              .onTapGesture { }
        }
      }
    }
    .padding(.leading, 12)
  }
}

// MARK: - HomePage.MostPlayedSongComponent.ViewState

extension HomePage.MostPlayedSongComponent {
  struct ViewState: Equatable {
    let item: MusicEntity.Chart.MostPlayedSong.Item
  }
}
