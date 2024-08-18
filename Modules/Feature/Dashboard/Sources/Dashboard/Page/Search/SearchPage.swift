import ComposableArchitecture
import DesignSystem
import Functor
import SwiftUI

// MARK: - SearchPage

struct SearchPage {
  @Bindable var store: StoreOf<SearchReducer>
  @State var throttleEvent: ThrottleEvent = .init(value: "", delaySeconds: 1.5)

  @Environment(\.colorScheme) private var colorScheme
}

extension SearchPage { }

// MARK: View

extension SearchPage: View {
  var body: some View {
    ScrollView {
      if !store.query.isEmpty {
        LazyVStack {
          ForEach(store.keywordItemList, id: \.searchTerm) { item in
            KeywordComponent(viewState: .init(item: item), store: store)
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
    }
    .overlay {
      if store.isShowSearchResult {
        // Category View
        ScrollView {
          VStack {
            CategoryComponent(
              viewState: .init(),
              store: store)

            Divider()
              .padding(.leading, 12)

            // 검색 결과 view
            switch store.category {
            case .topResult:
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

            case .artist:
              LazyVStack {
                ForEach(store.artistItemList, id: \.id) { item in
                  ArtistComponent(viewState: .init(item: item))
                    .onAppear {
                      guard let last = store.artistItemList.last, last.id == item.id else { return }
                      guard !store.fetchSearchArtistItem.isLoading else { return }
                      store.send(.searchArtist(store.query))
                    }
                }
              }
              .padding(.top, 24)
              .onAppear {
                store.send(.searchArtist(store.query))
              }

            case .album:
              LazyVStack {
                ForEach(store.albumItemList, id: \.id) { item in
                  AlbumComponent(viewState: .init(item: item))
                    .onAppear {
                      guard let last = store.albumItemList.last, last.id == item.id else { return }
                      guard !store.fetchSearchAlbumItem.isLoading else { return }
                      store.send(.searchAlbum(store.query))
                    }
                }
              }
              .padding(.top, 24)
              .onAppear {
                store.send(.searchAlbum(store.query))
              }

            case .song:
              LazyVStack {
                ForEach(store.songItemList, id: \.id) { item in
                  SongComponent(viewState: .init(item: item))
                    .onAppear {
                      guard let last = store.songItemList.last, last.id == item.id else { return }
                      guard !store.fetchSearchSongItem.isLoading else { return }
                      store.send(.searchSong(store.query))
                    }
                }
              }
              .padding(.top, 24)
              .onAppear {
                store.send(.searchSong(store.query))
              }

            case .playList:
              LazyVStack {
                ForEach(store.playList, id: \.id) { item in
                  PlayListComponent(viewState: .init(item: item))
                    .onAppear {
                      guard let last = store.playList.last, last.id == item.id else { return }
                      guard !store.fetchSearchPlayItem.isLoading else { return }
                      store.send(.searchPlayList(store.query))
                    }
                }
              }
              .padding(.top, 24)
              .onAppear {
                store.send(.searchPlayList(store.query))
              }
            }
          }
        }
        .frame(maxWidth: .infinity)
        .background(
          colorScheme == .dark
            ? DesignSystemColor.system(.black).color
            : DesignSystemColor.system(.white).color)
      }
    }
    .searchable(
      text: $store.query,
      placement: .navigationBarDrawer(displayMode: .always),
      prompt: Text("검색어를 입력해주세요."))
    .onSubmit(of: .search) {
      store.category = .topResult
      store.isShowSearchResult = true
    }
    .navigationTitle("검색")
    .navigationBarTitleDisplayMode(.large)
    .onChange(of: store.query) { _, new in
      throttleEvent.update(value: new)
      store.isShowSearchResult = false
    }
    .onAppear {
      throttleEvent.apply { _ in
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
