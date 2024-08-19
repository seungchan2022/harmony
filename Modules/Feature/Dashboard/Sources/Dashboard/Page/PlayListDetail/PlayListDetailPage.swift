import ComposableArchitecture
import DesignSystem
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
        if let item = store.fetchItem.value {
          InfoComponent(viewState: .init(item: item))
        }

        ForEach(store.itemList, id: \.id) { item in
          ItemComponent(
            viewState: .init(item: item))
        }
      }
    }
    .navigationTitle("")
    .navigationBarTitleDisplayMode(.inline)
    .onAppear {
      store.send(.getItem(store.requestModel))
    }
  }
}
