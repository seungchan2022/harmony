import ComposableArchitecture
import SwiftUI

// MARK: - SimilarArtistPage

struct SimilarArtistPage {
  @Bindable var store: StoreOf<SimilarArtistReducer>
}

extension SimilarArtistPage { }

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
    .onAppear {
      store.send(.getItem(store.requestModel))
    }
  }
}
