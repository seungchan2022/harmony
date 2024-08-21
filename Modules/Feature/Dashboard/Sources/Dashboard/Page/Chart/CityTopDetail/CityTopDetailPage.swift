import ComposableArchitecture
import DesignSystem
import SwiftUI

// MARK: - CityTopDetailPage

struct CityTopDetailPage {
  @Bindable var store: StoreOf<CityTopDetailReducer>
}

extension CityTopDetailPage {
  private var isLoading: Bool {
    store.fetchItem.isLoading
  }
}

// MARK: View

extension CityTopDetailPage: View {
  var body: some View {
    ScrollView {
      LazyVStack {
        ForEach(store.itemList, id: \.id) { item in
          ItemComponent(
            viewState: .init(item: item),
            store: store)
        }
      }
    }
    .navigationTitle(store.item.name)
    .setRequestFlightView(isLoading: isLoading)
    .onAppear {
      store.send(.getItem(store.item))
    }
    .onDisappear {
      store.send(.teardown)
    }
  }
}
