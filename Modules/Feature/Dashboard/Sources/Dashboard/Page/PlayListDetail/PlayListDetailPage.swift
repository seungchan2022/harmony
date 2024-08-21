import ComposableArchitecture
import DesignSystem
import SwiftUI

// MARK: - PlayListDetailPage

struct PlayListDetailPage {
  @Bindable var store: StoreOf<PlayListDetailReducer>
}

extension PlayListDetailPage {
  private var isLoading: Bool {
    store.fetchItem.isLoading
  }
}

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
    .setRequestFlightView(isLoading: isLoading)
    .onAppear {
      store.send(.getItem(store.requestModel))
    }
    .onDisappear {
      store.send(.teardown)
    }
  }
}
