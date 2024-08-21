import ComposableArchitecture
import DesignSystem
import SwiftUI

// MARK: - FullAlbumPage

struct FullAlbumPage {
  @Bindable var store: StoreOf<FullAlbumReducer>
}

extension FullAlbumPage {
  private var gridItemList: [GridItem] {
    .init(repeating: .init(.flexible(maximum: 180)), count: 2)
  }

  private var isLoading: Bool {
    store.fetchItem.isLoading
  }
}

// MARK: View

extension FullAlbumPage: View {
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
    .navigationTitle("앨범")
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
