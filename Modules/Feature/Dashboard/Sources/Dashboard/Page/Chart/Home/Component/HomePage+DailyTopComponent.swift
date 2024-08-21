import ComposableArchitecture
import DesignSystem
import Domain
import SwiftUI

// MARK: - HomePage.DailyTopComponent

extension HomePage {
  struct DailyTopComponent {
    let viewState: ViewState
    let tapAction: (MusicEntity.Chart.DailyTop.Item) -> Void

    @Environment(\.colorScheme) private var colorScheme

  }
}

extension HomePage.DailyTopComponent { }

// MARK: - HomePage.DailyTopComponent + View

extension HomePage.DailyTopComponent: View {
  var body: some View {
    Button(action: { tapAction(viewState.item) }) {
      VStack(alignment: .leading, spacing: 4) {
        RemoteImage(url: viewState.item.artwork.url?.absoluteString ?? "") {
          RoundedRectangle(cornerRadius: 8)
            .fill(.gray.opacity(0.3))
            .frame(width: 180, height: 180)
        }
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .frame(width: 180, height: 180)

        Text(viewState.item.name)
          .font(.body)
          .foregroundStyle(
            colorScheme == .dark
              ? DesignSystemColor.system(.white).color
              : DesignSystemColor.system(.black).color)

        Text(viewState.item.curatorName)
          .font(.subheadline)
          .foregroundStyle(DesignSystemColor.palette(.gray(.lv300)).color)
      }
    }
    .padding(.leading, 12)
  }
}

// MARK: - HomePage.DailyTopComponent.ViewState

extension HomePage.DailyTopComponent {
  struct ViewState: Equatable {
    let item: MusicEntity.Chart.DailyTop.Item
  }
}
