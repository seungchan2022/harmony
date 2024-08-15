import ComposableArchitecture
import DesignSystem
import Domain
import SwiftUI

// MARK: - ArtistPage.TopSongComponent

extension ArtistPage {
  struct TopSongComponent {
    let viewState: ViewState

    @Environment(\.colorScheme) private var colorScheme
  }
}

extension ArtistPage.TopSongComponent { }

// MARK: - ArtistPage.TopSongComponent + View

extension ArtistPage.TopSongComponent: View {
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

          VStack(alignment: .leading, spacing: 4) {
            Text(viewState.item.title)
              .font(.body)
              .foregroundStyle(
                colorScheme == .dark
                  ? DesignSystemColor.system(.white).color
                  : DesignSystemColor.system(.black).color)
                .multilineTextAlignment(.leading)
                .lineLimit(1)

            HStack {
              Text(viewState.item.artistName)
                .font(.footnote)
                .foregroundStyle(DesignSystemColor.palette(.gray(.lv300)).color)
                .multilineTextAlignment(.leading)
                .lineLimit(1)

              Text("• \(viewState.item.releaseDate.formatted(.dateTime.year(.defaultDigits)))년")
                .font(.footnote)
                .foregroundStyle(DesignSystemColor.palette(.gray(.lv300)).color)
            }
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

// MARK: - ArtistPage.TopSongComponent.ViewState

extension ArtistPage.TopSongComponent {
  struct ViewState: Equatable {
    let item: MusicEntity.Artist.TopSong.Item
  }
}
