import DesignSystem
import Domain
import SwiftUI

// MARK: - SearchPage.PlayListComponent

extension SearchPage {
  struct PlayListComponent {
    let viewState: ViewState
    let tapAction: (MusicEntity.Search.PlayList.Item) -> Void

    @Environment(\.colorScheme) private var colorScheme
  }
}

extension SearchPage.PlayListComponent { }

// MARK: - SearchPage.PlayListComponent + View

extension SearchPage.PlayListComponent: View {
  var body: some View {
    Button(action: { tapAction(viewState.item) }) {
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
            Text(viewState.item.name)
              .font(.body)
              .foregroundStyle(
                colorScheme == .dark
                  ? DesignSystemColor.system(.white).color
                  : DesignSystemColor.system(.black).color)

            Text(viewState.item.curatorName)
              .font(.caption)
              .foregroundStyle(DesignSystemColor.palette(.gray(.lv300)).color)
          }
          .multilineTextAlignment(.leading)
          .lineLimit(1)

          Spacer()

          Image(systemName: "chevron.right")
            .foregroundStyle(DesignSystemColor.palette(.gray(.lv400)).color)
        }

        Divider()
      }
      .padding(.horizontal, 12)
    }
  }
}

// MARK: - SearchPage.PlayListComponent.ViewState

extension SearchPage.PlayListComponent {
  struct ViewState: Equatable {
    let item: MusicEntity.Search.PlayList.Item
  }
}
