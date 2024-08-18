import ComposableArchitecture
import SwiftUI

// MARK: - PlayListDetailPage

struct PlayListDetailPage {
  @Bindable var store: StoreOf<PlayListDetailReducer>
}

extension PlayListDetailPage { }

// MARK: View

extension PlayListDetailPage: View {
  var body: some View {
    ScrollView {
      LazyVStack {
        ForEach(store.itemList, id: \.id) { item in
          ItemComponent(
            viewState: .init(item: item))
        }
      }
    }
    .onAppear {
      store.send(.getItem(store.requestModel))
    }
  }
}
