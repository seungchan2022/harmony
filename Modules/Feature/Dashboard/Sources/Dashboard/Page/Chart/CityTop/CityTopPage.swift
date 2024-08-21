import ComposableArchitecture
import DesignSystem
import SwiftUI

// MARK: - CityTopPage

struct CityTopPage {
  @Bindable var store: StoreOf<CityTopReducer>
}

extension CityTopPage {
  private var gridItemList: [GridItem] {
    .init(repeating: .init(.flexible(maximum: 180)), count: 2)
  }

  private var isLoading: Bool {
    store.fetchItem.isLoading
  }
}

// MARK: View

extension CityTopPage: View {
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
    .navigationTitle("도시별 차트")
    .setRequestFlightView(isLoading: isLoading)
    .onAppear {
      store.send(.getItem)
    }
    .onDisappear {
      store.send(.teardown)
    }
  }
}
