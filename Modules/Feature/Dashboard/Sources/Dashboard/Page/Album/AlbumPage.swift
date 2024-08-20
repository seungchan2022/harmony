import ComposableArchitecture
import SwiftUI

// MARK: - AlbumPage

struct AlbumPage {
  @Bindable var store: StoreOf<AlbumReducer>
}

extension AlbumPage { }

// MARK: View

extension AlbumPage: View {
  var body: some View {
    VStack {
      Text("\(store.itemList.count)")
    }
    .onAppear {
      store.send(.getItem(store.requestModel))
    }
  }
}
