import DesignSystem
import Domain
import SwiftUI

// MARK: - SearchPage.SongComponent

extension SearchPage {
  struct SongComponent {
    let viewState: ViewState

    @Environment(\.colorScheme) private var colorScheme
  }
}

extension SearchPage.SongComponent { }

// MARK: - SearchPage.SongComponent + View

extension SearchPage.SongComponent: View {
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

          VStack(alignment: .leading, spacing: 4) {
            Text(viewState.item.title)
              .font(.body)
              .foregroundStyle(
                colorScheme == .dark
                  ? DesignSystemColor.system(.white).color
                  : DesignSystemColor.system(.black).color)

            Text("노래 • \(viewState.item.artistName)")
              .font(.subheadline)
              .foregroundStyle(DesignSystemColor.palette(.gray(.lv300)).color)
          }
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
        .padding(.horizontal, 12)

        Divider()
          .padding(.leading, 76)
      }
    }
  }
}

// MARK: - SearchPage.SongComponent.ViewState

extension SearchPage.SongComponent {
  struct ViewState: Equatable {
    let item: MusicEntity.Search.Song.Item
  }
}
