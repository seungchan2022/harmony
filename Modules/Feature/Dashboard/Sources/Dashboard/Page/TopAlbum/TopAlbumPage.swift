import ComposableArchitecture
import DesignSystem
import SwiftUI

// MARK: - TopAlbumPage

struct TopAlbumPage {
  @Bindable var store: StoreOf<TopAlbumReducer>
}

extension TopAlbumPage {
  private var gridItemList: [GridItem] {
    .init(repeating: .init(.flexible(maximum: 180)), count: 2)
  }
}

// MARK: View

extension TopAlbumPage: View {
  var body: some View {
    ScrollView {
      LazyVGrid(columns: gridItemList, spacing: 20) {
        ForEach(store.itemList, id: \.id) { item in
          ItemComponent(
            viewState: .init(item: item),
            store: store)
        }
      }
    }
    .navigationTitle("인기 앨범")
    .onAppear {
      store.send(.getItem)
    }
  }
}
