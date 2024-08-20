import ComposableArchitecture
import SwiftUI

// MARK: - DailyTopDetailPage

struct DailyTopDetailPage {
  @Bindable var store: StoreOf<DailyTopDetailReducer>
}

extension DailyTopDetailPage { }

// MARK: View

extension DailyTopDetailPage: View {
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
