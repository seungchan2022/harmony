import ComposableArchitecture
import DesignSystem
import Domain
import SwiftUI

// MARK: - SearchPage.TopResultComponent

extension SearchPage {
  struct TopResultComponent {
    let viewState: ViewState
    let tapAction: (MusicEntity.Search.TopResult.Item) -> Void

    @Bindable var store: StoreOf<SearchReducer>
    @Environment(\.colorScheme) private var colorScheme
  }
}

extension SearchPage.TopResultComponent { }

// MARK: - SearchPage.TopResultComponent + View

extension SearchPage.TopResultComponent: View {
  var body: some View {
    switch viewState.item.itemType {
    case .artist:
      Button(action: { tapAction(viewState.item) }) {
        VStack(alignment: .leading) {
          HStack(spacing: 12) {
            RemoteImage(url: viewState.item.artwork.url?.absoluteString ?? "") {
              Circle()
                .fill(.gray.opacity(0.3))
                .frame(width: 60, height: 60)
                .overlay {
                  Image(systemName: "music.mic.circle.fill")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .foregroundStyle(.thickMaterial)
                }
            }
            .frame(width: 60, height: 60)
            .clipShape(Circle())

            if let name = viewState.item.name {
              VStack(alignment: .leading, spacing: 4) {
                Text(name)
                  .font(.body)
                  .foregroundStyle(
                    colorScheme == .dark
                      ? DesignSystemColor.system(.white).color
                      : DesignSystemColor.system(.black).color)
                    .multilineTextAlignment(.leading)

                Text("아티스트")
                  .font(.subheadline)
                  .foregroundStyle(DesignSystemColor.palette(.gray(.lv300)).color)
              }
            }

            Spacer()

            Image(systemName: "chevron.right")
              .foregroundStyle(DesignSystemColor.palette(.gray(.lv400)).color)
          }
          .padding(.horizontal, 12)

          Divider()
            .padding(.leading, 76)
        }
      }

    case .song:

      Button(action: { }) {
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
              if let title = viewState.item.title {
                Text(title)
                  .font(.body)
                  .foregroundStyle(
                    colorScheme == .dark
                      ? DesignSystemColor.system(.white).color
                      : DesignSystemColor.system(.black).color)
                    .multilineTextAlignment(.leading)
                    .lineLimit(1)
              }

              if let artistName = viewState.item.artistName {
                Text("노래 • \(artistName)")
                  .font(.subheadline)
                  .foregroundStyle(DesignSystemColor.palette(.gray(.lv300)).color)
                  .lineLimit(1)
              }
            }

            Spacer()

            Image(systemName: "chevron.right")
              .foregroundStyle(DesignSystemColor.palette(.gray(.lv400)).color)
          }
          .padding(.horizontal, 12)

          Divider()
            .padding(.leading, 76)
        }
      }

    case .album:
      Button(action: { }) {
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
              if let title = viewState.item.title {
                Text(title)
                  .font(.body)
                  .foregroundStyle(
                    colorScheme == .dark
                      ? DesignSystemColor.system(.white).color
                      : DesignSystemColor.system(.black).color)
                    .multilineTextAlignment(.leading)
                    .lineLimit(1)
              }

              if let artistName = viewState.item.artistName {
                Text("앨범 • \(artistName)")
                  .font(.subheadline)
                  .foregroundStyle(DesignSystemColor.palette(.gray(.lv300)).color)
                  .lineLimit(1)
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
          .padding(.horizontal, 12)

          Divider()
            .padding(.leading, 76)
        }
      }

    case .unknown:
      EmptyView()
    }
  }
}

// MARK: - SearchPage.TopResultComponent.ViewState

extension SearchPage.TopResultComponent {
  struct ViewState: Equatable {
    let item: MusicEntity.Search.TopResult.Item
  }
}
