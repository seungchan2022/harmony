import ComposableArchitecture
import DesignSystem
import SwiftUI

// MARK: - AlbumDetailPage

struct AlbumDetailPage {
  @Bindable var store: StoreOf<AlbumDetailReducer>
  @Environment(\.colorScheme) private var colorScheme

}

extension AlbumDetailPage { }

// MARK: View

extension AlbumDetailPage: View {
  var body: some View {
    ScrollView {
      LazyVStack {
        VStack(spacing: 8) {
          RemoteImage(url: store.item.artwork.url?.absoluteString ?? "") {
            RoundedRectangle(cornerRadius: 8)
              .fill(.gray.opacity(0.3))
              .frame(width: 180, height: 180)
          }
          .frame(width: 180, height: 180)
          .clipShape(RoundedRectangle(cornerRadius: 8))

          Text(store.item.title)
            .font(.title)
            .fontWeight(.bold)
            .foregroundStyle(
              colorScheme == .dark
                ? DesignSystemColor.system(.white).color
                : DesignSystemColor.system(.black).color)
              .multilineTextAlignment(.leading)
              .lineLimit(1)

          Text(store.item.artistName)
            .font(.headline)
            .foregroundStyle(DesignSystemColor.tint(.red).color)

          HStack {
            Text(store.item.genreItemList.first ?? "")

            Text("\(store.item.releaseDate?.formatted(.dateTime.year(.defaultDigits)) ?? "") 년")
          }
          .font(.body)
          .foregroundStyle(DesignSystemColor.palette(.gray(.lv400)).color)
        }

        Divider()
          .padding(.leading, 20)

        ForEach(store.itemList, id: \.id) { item in
          ItemComponent(
            viewState: .init(item: item))
        }
      }
    }
    .navigationBarTitleDisplayMode(.inline)
    .onAppear {
      store.send(.getItem(store.item))
    }
  }
}
