import ComposableArchitecture
import SwiftUI
import DesignSystem

// MARK: - CityTopDetailPage

struct CityTopDetailPage {
  @Bindable var store: StoreOf<CityTopDetailReducer>
}

extension CityTopDetailPage { }

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
    .onAppear {
      store.send(.getItem(store.item))
    }
  }
}
