import ComposableArchitecture
import DesignSystem
import Domain
import SwiftUI

// MARK: - ArtistPage.MusicVideoComponent

extension ArtistPage {
  struct MusicVideoComponent {
    let viewState: ViewState

    @Environment(\.colorScheme) private var colorScheme
  }
}

extension ArtistPage.MusicVideoComponent { }

// MARK: - ArtistPage.MusicVideoComponent + View

extension ArtistPage.MusicVideoComponent: View {
  var body: some View {
    Button(action: { }) {
      VStack(alignment: .leading) {
        RemoteImage(url: viewState.item.artwork.url?.absoluteString ?? "") {
          RoundedRectangle(cornerRadius: 8)
            .fill(.gray.opacity(0.3))
            .frame(width: 320, height: 200)
        }
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .frame(width: 320, height: 200)

        Text(viewState.item.title)
          .font(.footnote)
          .foregroundStyle(
            colorScheme == .dark
              ? DesignSystemColor.system(.white).color
              : DesignSystemColor.system(.black).color)
            .multilineTextAlignment(.leading)
            .lineLimit(1)

        Text("\(viewState.item.releaseDate.formatted(.dateTime.year(.defaultDigits)))년")
          .font(.footnote)
          .foregroundStyle(DesignSystemColor.palette(.gray(.lv300)).color)
      }
    }
  }
}

// MARK: - ArtistPage.MusicVideoComponent.ViewState

extension ArtistPage.MusicVideoComponent {
  struct ViewState: Equatable {
    let item: MusicEntity.Artist.MusicVideo.Item
  }
}
