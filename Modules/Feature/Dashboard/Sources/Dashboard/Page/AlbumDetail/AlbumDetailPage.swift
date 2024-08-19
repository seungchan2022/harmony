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
        if let item = store.fetchItem.value {
          InfoComponent(viewState: .init(item: item))

          Divider()
            .padding(.leading, 20)

          ForEach(store.itemList, id: \.id) { item in
            ItemComponent(
              viewState: .init(item: item))
          }
        }
      }
    }
    .navigationBarTitleDisplayMode(.inline)
    .onAppear {
      store.send(.getItem)
    }
  }
}
