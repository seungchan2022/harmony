import ComposableArchitecture
import DesignSystem
import SwiftUI

// MARK: - TopSongPage

struct TopSongPage {
  @Bindable var store: StoreOf<TopSongReducer>
}

extension TopSongPage {
  private var isLoading: Bool {
    store.fetchItem.isLoading
  }
}

// MARK: View

extension TopSongPage: View {
  var body: some View {
    ScrollView {
      LazyVStack {
        ForEach(store.itemList) { item in
          ItemComponent(viewState: .init(item: item))
        }
      }
    }
    .navigationTitle("인기곡")
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
