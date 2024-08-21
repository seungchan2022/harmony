import ComposableArchitecture
import SwiftUI

// MARK: - TopSongPage

struct TopSongPage {
  @Bindable var store: StoreOf<TopSongReducer>
}

extension TopSongPage { }

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
    .onAppear {
      store.send(.getItem(store.requestModel))
    }
  }
}
