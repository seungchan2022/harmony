import DesignSystem
import Domain
import SwiftUI

// MARK: - PlayListDetailPage.InfoComponent

extension PlayListDetailPage {
  struct InfoComponent {
    let viewState: ViewState

    @Environment(\.colorScheme) var colorScheme
  }
}

extension PlayListDetailPage.InfoComponent { }

// MARK: - PlayListDetailPage.InfoComponent + View

extension PlayListDetailPage.InfoComponent: View {
  var body: some View {
    VStack {
      RemoteImage(url: viewState.item.artwork.url?.absoluteString ?? "") {
        RoundedRectangle(cornerRadius: 8)
          .fill(.gray.opacity(0.3))
          .frame(width: 180, height: 180)
      }
      .frame(width: 180, height: 180)
      .clipShape(RoundedRectangle(cornerRadius: 8))

      Text(viewState.item.name)
        .font(.title)
        .fontWeight(.bold)
        .foregroundStyle(
          colorScheme == .dark
            ? DesignSystemColor.system(.white).color
            : DesignSystemColor.system(.black).color)
          .lineLimit(1)

      Text(viewState.item.curatorName)
        .font(.headline)
        .foregroundStyle(DesignSystemColor.tint(.red).color)

      Divider()
        .padding(.leading, 12)
    }
  }
}

// MARK: - PlayListDetailPage.InfoComponent.ViewState

extension PlayListDetailPage.InfoComponent {
  struct ViewState: Equatable {
    let item: MusicEntity.PlayListDetail.Track.Response
  }
}
