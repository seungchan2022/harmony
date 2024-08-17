import ComposableArchitecture
import DesignSystem
import Functor
import SwiftUI

// MARK: - SearchPage

struct SearchPage {
  @Bindable var store: StoreOf<SearchReducer>
  @State var throttleEvent: ThrottleEvent = .init(value: "", delaySeconds: 1.5)

}

extension SearchPage { }

// MARK: View

extension SearchPage: View {
  var body: some View {
    ScrollView {
      LazyVStack {
        if !store.query.isEmpty {
          Divider()
            .padding(.leading, 12)

          ForEach(store.keywordItemList, id: \.searchTerm) { item in
            KeywordComponent(viewState: .init(item: item), store: store)
          }
        }
      }

      LazyVStack {
        ForEach(store.topResultItemList, id: \.id) { item in

          TopResultComponent(
            viewState: .init(item: item),
            tapAritistAction: { store.send(.routeToArtist($0)) },
            tapAlbumAction: { store.send(.routeToAlbumDetail($0)) },
            store: store)
        }
      }
      .padding(.top, 24)
    }
    .searchable(
      text: $store.query,
      placement: .navigationBarDrawer(displayMode: .always),
      prompt: Text("검색어를 입력해주세요."))
    .navigationTitle("검색")
    .navigationBarTitleDisplayMode(.large)
    .onChange(of: store.query) { _, new in
      throttleEvent.update(value: new)
    }
    .onAppear {
      throttleEvent.apply { _ in
//        store.send(.searchSong(store.query))
//        store.send(.searchArtist(store.query))
//        store.send(.searchAlbum(store.query))
        store.send(.searchTopResult(store.query))
        store.send(.searchKeyword(store.query))
      }
    }
    .onDisappear {
      throttleEvent.reset()
      store.send(.teardown)
    }
  }
}
