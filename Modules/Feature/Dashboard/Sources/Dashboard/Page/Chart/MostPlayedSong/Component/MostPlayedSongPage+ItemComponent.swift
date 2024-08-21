import ComposableArchitecture
import DesignSystem
import Domain
import SwiftUI

// MARK: - MostPlayedSongPage.ItemComponent

extension MostPlayedSongPage {
  struct ItemComponent {
    let viewState: ViewState

    @Bindable var store: StoreOf<MostPlayedSongReducer>

    @Environment(\.colorScheme) private var colorScheme

  }
}

extension MostPlayedSongPage.ItemComponent {
  private var ranking: Int {
    (store.itemList.firstIndex(of: viewState.item) ?? .zero) + 1
  }
}

// MARK: - MostPlayedSongPage.ItemComponent + View

extension MostPlayedSongPage.ItemComponent: View {
  var body: some View {
    Button(action: { }) {
      VStack(alignment: .leading) {
        HStack(spacing: 12) {
          RemoteImage(url: viewState.item.artwork.url?.absoluteString ?? "") {
            RoundedRectangle(cornerRadius: 8)
              .fill(.gray.opacity(0.3))
              .frame(width: 60, height: 60)
          }
          .clipShape(RoundedRectangle(cornerRadius: 8))
          .frame(width: 60, height: 60)

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
                .multilineTextAlignment(.leading)

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
        .padding(.horizontal, 12)

        Divider()
          .padding(.leading, 76)
      }
    }
  }
}

// MARK: - MostPlayedSongPage.ItemComponent.ViewState

extension MostPlayedSongPage.ItemComponent {
  struct ViewState: Equatable {
    let item: MusicEntity.Chart.MostPlayedSong.Item
  }
}
