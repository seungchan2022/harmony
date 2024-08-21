import Architecture
import ComposableArchitecture
import Domain
import Foundation

// MARK: - CategoryList

enum CategoryList: String, Equatable, CaseIterable {
  case topResult
  case artist
  case album
  case song
  case playList
}

// MARK: - SearchReducer

@Reducer
struct SearchReducer {

  // MARK: Lifecycle

  init(
    pageID: String = UUID().uuidString,
    sideEffect: SearchSideEffect)
  {
    self.pageID = pageID
    self.sideEffect = sideEffect
  }

  // MARK: Internal

  @ObservableState
  struct State: Equatable, Identifiable {

    // MARK: Lifecycle

    init(id: UUID = UUID()) {
      self.id = id
    }

    // MARK: Internal

    let id: UUID

    var category: CategoryList = .topResult

    var isShowSearchResult = false

    var query = "iu"

    var songItemList: [MusicEntity.Search.Song.Item] = []
    var artistItemList: [MusicEntity.Search.Artist.Item] = []
    var albumItemList: [MusicEntity.Search.Album.Item] = []
    var playList: [MusicEntity.Search.PlayList.Item] = []
    var topResultItemList: [MusicEntity.Search.TopResult.Item] = []
    var keywordItemList: [MusicEntity.Search.Keyword.Item] = []

    var fetchSearchSongItem: FetchState.Data<MusicEntity.Search.Song.Composite?> = .init(isLoading: false, value: .none)
    var fetchSearchArtistItem: FetchState.Data<MusicEntity.Search.Artist.Composite?> = .init(isLoading: false, value: .none)
    var fetchSearchAlbumItem: FetchState.Data<MusicEntity.Search.Album.Composite?> = .init(isLoading: false, value: .none)
    var fetchSearchPlayItem: FetchState.Data<MusicEntity.Search.PlayList.Composite?> = .init(isLoading: false, value: .none)
    var fetchSearchTopResultItem: FetchState.Data<MusicEntity.Search.TopResult.Composite?> = .init(isLoading: false, value: .none)
    var fetchSearchKeywordItem: FetchState.Data<MusicEntity.Search.Keyword.Composite?> = .init(isLoading: false, value: .none)

  }

  enum Action: Equatable, BindableAction {
    case binding(BindingAction<State>)
    case teardown

    case searchSong(String)
    case searchArtist(String)
    case searchAlbum(String)
    case searchPlayList(String)
    case searchTopResult(String)

    case searchKeyword(String)

    case fetchSearchSongItem(Result<MusicEntity.Search.Song.Composite, CompositeErrorRepository>)
    case fetchSearchArtistItem(Result<MusicEntity.Search.Artist.Composite, CompositeErrorRepository>)
    case fetchSearchAlbumItem(Result<MusicEntity.Search.Album.Composite, CompositeErrorRepository>)
    case fetchSearchPlayItem(Result<MusicEntity.Search.PlayList.Composite, CompositeErrorRepository>)
    case fetchSearchTopResultItem(Result<MusicEntity.Search.TopResult.Composite, CompositeErrorRepository>)
    case fetchSearchKeywordItem(Result<MusicEntity.Search.Keyword.Composite, CompositeErrorRepository>)

    case routeToTopResultArtist(MusicEntity.Search.TopResult.Item)
    case routeToTopResultAlbumDetail(MusicEntity.Search.TopResult.Item)

    case routeToArtist(MusicEntity.Search.Artist.Item)
    case routeToAlbumDetail(MusicEntity.Search.Album.Item)
    case routeToPlayListDetail(MusicEntity.Search.PlayList.Item)

    case throwError(CompositeErrorRepository)
  }

  enum CancelID: String, CaseIterable {
    case teardown
    case requestSearchSong
    case requestSearchArtist
    case requestSearchAlbum
    case requestPlayList
    case requestSearchTopResult
    case requestSearchKeyword
  }

  var body: some Reducer<State, Action> {
    BindingReducer()
    Reduce { state, action in
      switch action {
      case .binding(\.query):
        guard !state.query.isEmpty else {
          state.songItemList = []
          state.artistItemList = []
          state.albumItemList = []
          state.playList = []
          state.topResultItemList = []
          state.keywordItemList = []
          return .none
        }

        if state.query != state.fetchSearchSongItem.value?.request.query {
          state.songItemList = []
        }

        if state.query != state.fetchSearchArtistItem.value?.request.query {
          state.artistItemList = []
        }

        if state.query != state.fetchSearchAlbumItem.value?.request.query {
          state.albumItemList = []
        }

        if state.query != state.fetchSearchPlayItem.value?.request.query {
          state.playList = []
        }

        if state.query != state.fetchSearchTopResultItem.value?.request.query {
          state.topResultItemList = []
        }

        if state.query != state.fetchSearchKeywordItem.value?.request.query {
          state.keywordItemList = []
        }

        return .none

      case .binding:
        return .none

      case .teardown:
        return .concatenate(
          CancelID.allCases.map { .cancel(pageID: pageID, id: $0) })

      case .searchSong(let query):
        guard !query.isEmpty else {
          return .none
        }

        state.fetchSearchSongItem.isLoading = true

        return sideEffect
          .song(.init(query: query, limit: 10, offset: state.songItemList.count))
          .cancellable(pageID: pageID, id: CancelID.requestSearchSong, cancelInFlight: true)

      case .searchArtist(let query):
        guard !query.isEmpty else {
          return .none
        }

        state.fetchSearchArtistItem.isLoading = true

        return sideEffect
          .artist(.init(query: query, limit: 10, offset: state.artistItemList.count))
          .cancellable(pageID: pageID, id: CancelID.requestSearchArtist, cancelInFlight: true)

      case .searchAlbum(let query):
        guard !query.isEmpty else { return .none }

        state.fetchSearchAlbumItem.isLoading = true

        return sideEffect
          .album(.init(query: query, limit: 10, offset: state.albumItemList.count))
          .cancellable(pageID: pageID, id: CancelID.requestSearchAlbum, cancelInFlight: true)

      case .searchPlayList(let query):
        guard !query.isEmpty else { return .none }
        state.fetchSearchPlayItem.isLoading = true
        return sideEffect
          .playList(.init(query: query, limit: 10, offset: state.playList.count))
          .cancellable(pageID: pageID, id: CancelID.requestPlayList, cancelInFlight: true)

      case .searchTopResult(let query):
        guard !query.isEmpty else { return .none }

        state.fetchSearchTopResultItem.isLoading = true

        return sideEffect
          .topResult(.init(query: query))
          .cancellable(pageID: pageID, id: CancelID.requestSearchTopResult, cancelInFlight: true)

      case .searchKeyword(let query):
        guard !query.isEmpty else { return .none }
        state.fetchSearchKeywordItem.isLoading = true
        return sideEffect
          .keyword(.init(query: query))
          .cancellable(pageID: pageID, id: CancelID.requestSearchKeyword, cancelInFlight: true)

      case .fetchSearchSongItem(let result):
        state.fetchSearchSongItem.isLoading = false
        switch result {
        case .success(let item):
          if state.query == item.request.query {
            state.fetchSearchSongItem.value = item
            state.songItemList = state.songItemList.merge(item.response.itemList)
          }

          return .none

        case .failure(let error):
          return .run { await $0(.throwError(error)) }
        }

      case .fetchSearchArtistItem(let result):
        state.fetchSearchArtistItem.isLoading = false
        switch result {
        case .success(let item):
          if state.query == item.request.query {
            state.fetchSearchArtistItem.value = item
            state.artistItemList = state.artistItemList.merge(item.response.itemList)
          }

          return .none

        case .failure(let error):
          return .run { await $0(.throwError(error)) }
        }

      case .fetchSearchAlbumItem(let result):
        state.fetchSearchAlbumItem.isLoading = false
        switch result {
        case .success(let item):
          if state.query == item.request.query {
            state.fetchSearchAlbumItem.value = item
            state.albumItemList = state.albumItemList.merge(item.response.itemList)
          }

          return .none

        case .failure(let error):
          return .run { await $0(.throwError(error)) }
        }

      case .fetchSearchPlayItem(let result):
        state.fetchSearchPlayItem.isLoading = false
        switch result {
        case .success(let item):
          if state.query == item.request.query {
            state.fetchSearchPlayItem.value = item
            state.playList = state.playList.merge(item.response.itemList)
          }

          return .none

        case .failure(let error):
          return .run { await $0(.throwError(error)) }
        }

      case .fetchSearchTopResultItem(let result):
        state.fetchSearchTopResultItem.isLoading = false
        switch result {
        case .success(let item):
          if state.query == item.request.query {
            state.fetchSearchTopResultItem.value = item
            state.topResultItemList = state.topResultItemList.merge(item.response.itemList)
          }

          return .none

        case .failure(let error):
          return .run { await $0(.throwError(error)) }
        }

      case .fetchSearchKeywordItem(let result):
        state.fetchSearchKeywordItem.isLoading = false
        switch result {
        case .success(let item):
          if state.query == item.request.query {
            state.fetchSearchKeywordItem.value = item
            state.keywordItemList = state.keywordItemList.merge(item.response.itemList)
          }
          return .none

        case .failure(let error):
          return .run { await $0(.throwError(error)) }
        }

      case .routeToTopResultArtist(let item):
        sideEffect.routeToTopResultArtist(item)
        return .none

      case .routeToTopResultAlbumDetail(let item):
        sideEffect.routeToTopResultAlbumDetail(item)
        return .none

      case .routeToArtist(let item):
        sideEffect.routeToArtist(item)
        return .none

      case .routeToAlbumDetail(let item):
        sideEffect.routeToAlbumDetail(item)
        return .none

      case .routeToPlayListDetail(let item):
        sideEffect.routeToPlayListDetail(item)
        return .none

      case .throwError(let error):
        sideEffect.useCase.toastViewModel.send(errorMessage: error.displayMessage)
        return .none
      }
    }
  }

  // MARK: Private

  private let pageID: String
  private let sideEffect: SearchSideEffect

}

extension [MusicEntity.Search.Keyword.Item] {
  fileprivate func merge(_ target: Self) -> Self {
    let new = target.reduce(self) { curr, next in
      guard !self.contains(where: { $0.id != next.id }) else { return curr }
      return curr + [next]
    }

    return new
  }
}

extension [MusicEntity.Search.TopResult.Item] {
  fileprivate func merge(_ target: Self) -> Self {
    let new = target.reduce(self) { curr, next in
      guard !self.contains(where: { $0.id == next.id }) else { return curr }
      return curr + [next]
    }
    return new
  }
}

extension [MusicEntity.Search.Artist.Item] {
  fileprivate func merge(_ target: Self) -> Self {
    let new = target.reduce(self) { curr, next in
      guard !self.contains(where: { $0.id == next.id }) else { return curr }
      return curr + [next]
    }
    return new
  }
}

extension [MusicEntity.Search.Album.Item] {
  fileprivate func merge(_ target: Self) -> Self {
    let new = target.reduce(self) { curr, next in
      guard !self.contains(where: { $0.id == next.id }) else { return curr }
      return curr + [next]
    }
    return new
  }
}

extension [MusicEntity.Search.PlayList.Item] {
  fileprivate func merge(_ target: Self) -> Self {
    let new = target.reduce(self) { curr, next in
      guard !self.contains(where: { $0.id == next.id }) else { return curr }
      return curr + [next]
    }
    return new
  }
}

extension [MusicEntity.Search.Song.Item] {
  fileprivate func merge(_ target: Self) -> Self {
    let new = target.reduce(self) { curr, next in
      guard !self.contains(where: { $0.id == next.id }) else { return curr }
      return curr + [next]
    }
    return new
  }
}
