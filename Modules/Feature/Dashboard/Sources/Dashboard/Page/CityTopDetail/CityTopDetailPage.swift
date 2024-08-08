import ComposableArchitecture
import SwiftUI

// MARK: - CityTopDetailPage

struct CityTopDetailPage {
  @Bindable var store: StoreOf<CityTopDetailReducer>
}

extension CityTopDetailPage { }

// MARK: View

extension CityTopDetailPage: View {
  var body: some View {
    VStack {
      ForEach(store.itemList, id: \.id) { item in
        Text(item.title)
      }
    }
    .onAppear {
      store.send(.getItem(store.item))
    }
  }
}
