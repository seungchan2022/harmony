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
    VStack {
      Text("\(store.itemList.count)")
    }
    .onAppear {
      store.send(.getItem(store.requestModel))
    }
  }
}
