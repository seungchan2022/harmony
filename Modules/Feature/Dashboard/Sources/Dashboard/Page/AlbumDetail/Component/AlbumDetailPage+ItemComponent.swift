import ComposableArchitecture
import DesignSystem
import Domain
import SwiftUI

// MARK: - AlbumDetailPage.ItemComponent

extension AlbumDetailPage {
  struct ItemComponent {
    let viewState: ViewState

    @Environment(\.colorScheme) private var colorScheme

  }
}

// MARK: - AlbumDetailPage.ItemComponent + View

extension AlbumDetailPage.ItemComponent: View {
  var body: some View {
    Button(action: { }) {
      VStack(alignment: .leading) {
        HStack(spacing: 12) {
          Text("\(viewState.item.trackNumber ?? .zero)")
            .font(.body)
            .foregroundStyle(DesignSystemColor.palette(.gray(.lv400)).color)

          Text(viewState.item.title)
            .font(.body)
            .foregroundStyle(
              colorScheme == .dark
                ? DesignSystemColor.system(.white).color
                : DesignSystemColor.system(.black).color)
              .multilineTextAlignment(.leading)
              .lineLimit(1)

          Spacer()

          Image(systemName: "ellipsis")
            .fontWeight(.bold)
            .foregroundStyle(
              colorScheme == .dark
                ? DesignSystemColor.system(.white).color
                : DesignSystemColor.system(.black).color)
              .onTapGesture { }
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 16)

        Divider()
          .padding(.leading, 32)
      }
    }
  }
}

// MARK: - AlbumDetailPage.ItemComponent.ViewState

extension AlbumDetailPage.ItemComponent {
  struct ViewState: Equatable {
    let item: MusicEntity.AlbumDetail.Track.Item
  }
}
