import ComposableArchitecture
import DesignSystem
import SwiftUI

// MARK: - AlbumDetailPage

struct AlbumDetailPage {
  @Bindable var store: StoreOf<AlbumDetailReducer>
  @Environment(\.colorScheme) private var colorScheme

}

extension AlbumDetailPage {
  private var isLoading: Bool {
    store.fetchItem.isLoading
  }
}

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
    .setRequestFlightView(isLoading: isLoading)
    .onAppear {
      store.send(.getItem)
    }
    .onDisappear {
      store.send(.teardown)
    }
  }
}
