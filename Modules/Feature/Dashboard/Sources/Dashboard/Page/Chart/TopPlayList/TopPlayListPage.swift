import ComposableArchitecture
import DesignSystem
import SwiftUI

// MARK: - TopPlayListPage

struct TopPlayListPage {
  @Bindable var store: StoreOf<TopPlayListReducer>
}

extension TopPlayListPage {
  private var gridItemList: [GridItem] {
    .init(repeating: .init(.flexible(maximum: 180)), count: 2)
  }

  private var isLoading: Bool {
    store.fetchItem.isLoading
  }
}

// MARK: View

extension TopPlayListPage: View {
  var body: some View {
    ScrollView {
      LazyVGrid(columns: gridItemList, spacing: 20) {
        ForEach(store.itemList, id: \.id) { item in
          ItemComponent(
            viewState: .init(item: item),
            tapAction: { store.send(.routeToDetail($0)) },
            store: store)
        }
      }
    }
    .navigationTitle("인기 플레이리스트")
    .setRequestFlightView(isLoading: isLoading)
    .onAppear {
      store.send(.getItem)
    }
    .onDisappear {
      store.send(.teardown)
    }
  }
}
