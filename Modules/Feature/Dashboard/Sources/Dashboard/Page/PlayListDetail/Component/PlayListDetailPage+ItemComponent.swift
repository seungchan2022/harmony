import ComposableArchitecture
import DesignSystem
import Domain
import SwiftUI

// MARK: - PlayListDetailPage.ItemComponent

extension PlayListDetailPage {
  struct ItemComponent {
    let viewState: ViewState

    @Environment(\.colorScheme) private var colorScheme
  }
}

extension PlayListDetailPage.ItemComponent { }

// MARK: - PlayListDetailPage.ItemComponent + View

extension PlayListDetailPage.ItemComponent: View {
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

// MARK: - PlayListDetailPage.ItemComponent.ViewState

extension PlayListDetailPage.ItemComponent {
  struct ViewState: Equatable {
    let item: MusicEntity.PlayListDetail.Track.Item
  }
}
