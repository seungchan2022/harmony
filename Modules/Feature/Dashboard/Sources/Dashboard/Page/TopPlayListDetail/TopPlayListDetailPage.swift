import ComposableArchitecture
import SwiftUI

// MARK: - TopPlayListDetailPage

struct TopPlayListDetailPage {
  @Bindable var store: StoreOf<TopPlayListDetailReducer>
}

extension TopPlayListDetailPage { }

// MARK: View

extension TopPlayListDetailPage: View {
  var body: some View {
    ScrollView {
      LazyVStack {
        ForEach(store.itemList, id: \.id) { item in
          ItemComponent(
            viewState: .init(item: item))
        }
      }
    }
    .navigationTitle(store.item.name)
    .onAppear {
      store.send(.getItem(store.item))
    }
  }
}
