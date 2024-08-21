import ComposableArchitecture
import DesignSystem
import SwiftUI

// MARK: - DailyTopPage

struct DailyTopPage {
  @Bindable var store: StoreOf<DailyTopReducer>
}

extension DailyTopPage {
  private var gridItemList: [GridItem] {
    .init(repeating: .init(.flexible(maximum: 180)), count: 2)
  }

  private var isLoading: Bool {
    store.fetchItem.isLoading
  }
}

// MARK: View

extension DailyTopPage: View {
  var body: some View {
    ScrollView {
      LazyVGrid(columns: gridItemList, spacing: 20) {
        ForEach(store.itemList, id: \.id) { item in
          ItemComponent(
            viewState: .init(item: item),
            tapAction: { store.send(.routeToDetail($0)) })
        }
      }
    }
    .navigationTitle("오늘의 TOP 100")
    .onAppear {
      store.send(.getItem)
    }
    .onDisappear {
      store.send(.teardown)
    }
  }
}
