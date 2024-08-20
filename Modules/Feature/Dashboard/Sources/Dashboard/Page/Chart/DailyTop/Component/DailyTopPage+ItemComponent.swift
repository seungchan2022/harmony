import ComposableArchitecture
import DesignSystem
import Domain
import SwiftUI

// MARK: - DailyTopPage.ItemComponent

extension DailyTopPage {
  struct ItemComponent {
    let viewState: ViewState
    let tapAction: (MusicEntity.Chart.DailyTop.Item) -> Void

    @Environment(\.colorScheme) private var colorScheme

  }
}

extension DailyTopPage.ItemComponent { }

// MARK: - DailyTopPage.ItemComponent + View

extension DailyTopPage.ItemComponent: View {
  var body: some View {
    Button(action: { tapAction(viewState.item) }) {
      VStack(alignment: .leading, spacing: 4) {
        RemoteImage(url: viewState.item.artwork.url?.absoluteString ?? "") {
          RoundedRectangle(cornerRadius: 8)
            .fill(.gray.opacity(0.3))
            .frame(width: 180, height: 180)
        }
        .frame(width: 180, height: 180)
        .clipShape(RoundedRectangle(cornerRadius: 8))

        Text(viewState.item.name)
          .font(.body)
          .foregroundStyle(
            colorScheme == .dark
              ? DesignSystemColor.system(.white).color
              : DesignSystemColor.system(.black).color)
            .lineLimit(1)
            .multilineTextAlignment(.leading)

        Text(viewState.item.curatorName)
          .font(.subheadline)
          .foregroundStyle(DesignSystemColor.palette(.gray(.lv300)).color)
          .multilineTextAlignment(.leading)
      }
    }
    .padding(.leading, 12)
  }
}

// MARK: - DailyTopPage.ItemComponent.ViewState

extension DailyTopPage.ItemComponent {
  struct ViewState: Equatable {
    let item: MusicEntity.Chart.DailyTop.Item
  }
}
