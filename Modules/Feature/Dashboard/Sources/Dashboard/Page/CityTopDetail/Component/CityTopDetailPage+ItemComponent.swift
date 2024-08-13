import SwiftUI
import ComposableArchitecture
import Domain
import DesignSystem

extension CityTopDetailPage {
  struct ItemComponent {
    let viewState: ViewState

    @Bindable var store: StoreOf<CityTopDetailReducer>

    @Environment(\.colorScheme) private var colorScheme
  }
}

extension CityTopDetailPage.ItemComponent { 
  private var ranking: Int {
    (store.itemList.firstIndex(of: viewState.item) ?? .zero) + 1
  }
}

// MARK: - SearchPage.SongComponent + View

extension CityTopDetailPage.ItemComponent: View {
  var body: some View {
    Button(action: { }) {
      VStack(alignment: .leading) {
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
                .multilineTextAlignment(.leading)
                .lineLimit(1)

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

// MARK: - SearchPage.SongComponent.ViewState

extension CityTopDetailPage.ItemComponent {
  struct ViewState: Equatable {
    let item: MusicEntity.CityTopDetail.Track.Item
  }
}

