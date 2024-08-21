import ComposableArchitecture
import SwiftUI

// MARK: - SingleAlbumPage

struct SingleAlbumPage {
  @Bindable var store: StoreOf<SingleAlbumReducer>
}

extension SingleAlbumPage {
  private var gridItemList: [GridItem] {
    .init(repeating: .init(.flexible(maximum: 180)), count: 2)
  }

  private var isLoading: Bool {
    store.fetchItem.isLoading
  }
}

// MARK: View

extension SingleAlbumPage: View {
  var body: some View {
    ScrollView {
      LazyVGrid(columns: gridItemList, spacing: 20) {
        ForEach(store.itemList, id: \.id) { item in
          ItemComponent(
            viewState: .init(item: item),
            tapAction: { store.send(.routeToDetail($0)) })
        }
      }
    }
    .navigationTitle("싱글 및 EP")
    .navigationBarTitleDisplayMode(.inline)
    .setRequestFlightView(isLoading: isLoading)
    .onAppear {
      store.send(.getItem(store.requestModel))
    }
    .onDisappear {
      store.send(.teardown)
    }
  }
}
