import ComposableArchitecture
import DesignSystem
import Domain
import SwiftUI

// MARK: - HomePage.CityTopComponent

extension HomePage {
  struct CityTopComponent {
    let viewState: ViewState
    let tapAction: (MusicEntity.Chart.CityTop.Item) -> Void

    @Environment(\.colorScheme) private var colorScheme

  }
}

extension HomePage.CityTopComponent { }

// MARK: - HomePage.CityTopComponent + View

extension HomePage.CityTopComponent: View {
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

        Text(viewState.item.curatorName ?? "")
          .font(.subheadline)
          .foregroundStyle(DesignSystemColor.palette(.gray(.lv300)).color)
      }
    }
    .padding(.leading, 12)
  }
}

// MARK: - HomePage.CityTopComponent.ViewState

extension HomePage.CityTopComponent {
  struct ViewState: Equatable {
    let item: MusicEntity.Chart.CityTop.Item
  }
}
