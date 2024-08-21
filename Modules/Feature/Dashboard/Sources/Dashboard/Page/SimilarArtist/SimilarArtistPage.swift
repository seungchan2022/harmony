import ComposableArchitecture
import DesignSystem
import SwiftUI

// MARK: - SimilarArtistPage

struct SimilarArtistPage {
  @Bindable var store: StoreOf<SimilarArtistReducer>
}

extension SimilarArtistPage {
  private var isLoading: Bool {
    store.fetchItem.isLoading
  }
}

// MARK: View

extension SimilarArtistPage: View {
  var body: some View {
    ScrollView {
      LazyVStack {
        ForEach(store.itemList, id: \.id) { item in
          ItemComponent(
            viewState: .init(item: item),
            tapAction: { store.send(.routeToArtist($0)) })
        }
      }
    }
    .navigationTitle("유사한 아티스트")
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
