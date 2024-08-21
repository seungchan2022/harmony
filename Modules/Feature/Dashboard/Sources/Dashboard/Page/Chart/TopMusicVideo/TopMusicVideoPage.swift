import ComposableArchitecture
import DesignSystem
import SwiftUI

// MARK: - TopMusicVideoPage

struct TopMusicVideoPage {
  @Bindable var store: StoreOf<TopMusicVideoReducer>
}

extension TopMusicVideoPage {
  private var gridItemList: [GridItem] {
    .init(repeating: .init(.flexible(maximum: 180)), count: 2)
  }

  private var isLoading: Bool {
    store.fetchItem.isLoading
  }

}

// MARK: View

extension TopMusicVideoPage: View {
  var body: some View {
    ScrollView {
      LazyVGrid(columns: gridItemList, spacing: 20) {
        ForEach(store.itemList, id: \.id) { item in
          ItemComponent(viewState: .init(item: item), store: store)
        }
      }
    }
    .navigationTitle("인기 뮤직비디오")
    .setRequestFlightView(isLoading: isLoading)
    .onAppear {
      store.send(.getItem)
    }
    .onDisappear {
      store.send(.teardown)
    }
  }
}
