import DesignSystem
import Domain
import SwiftUI

// MARK: - AlbumDetailPage.InfoComponent

extension AlbumDetailPage {
  struct InfoComponent {
    let viewState: ViewState

    @Environment(\.colorScheme) var colorScheme
  }
}

extension AlbumDetailPage.InfoComponent { }

// MARK: - AlbumDetailPage.InfoComponent + View

extension AlbumDetailPage.InfoComponent: View {
  var body: some View {
    VStack(spacing: 8) {
      RemoteImage(url: viewState.item.artwork.url?.absoluteString ?? "") {
        RoundedRectangle(cornerRadius: 8)
          .fill(.gray.opacity(0.3))
          .frame(width: 180, height: 180)
      }
      .frame(width: 180, height: 180)
      .clipShape(RoundedRectangle(cornerRadius: 8))

      Text(viewState.item.title)
        .font(.title)
        .fontWeight(.bold)
        .foregroundStyle(
          colorScheme == .dark
            ? DesignSystemColor.system(.white).color
            : DesignSystemColor.system(.black).color)
          .multilineTextAlignment(.leading)
          .lineLimit(1)

      Text(viewState.item.artistName)
        .font(.headline)
        .foregroundStyle(DesignSystemColor.tint(.red).color)

      HStack {
        Text(viewState.item.genreItemList.first ?? "")

        Text("\(viewState.item.releaseDate?.formatted(.dateTime.year(.defaultDigits)) ?? "") 년")
      }
      .font(.body)
      .foregroundStyle(DesignSystemColor.palette(.gray(.lv400)).color)
    }
  }
}

// MARK: - AlbumDetailPage.InfoComponent.ViewState

extension AlbumDetailPage.InfoComponent {
  struct ViewState: Equatable {
    let item: MusicEntity.AlbumDetail.Track.Item
  }

}
