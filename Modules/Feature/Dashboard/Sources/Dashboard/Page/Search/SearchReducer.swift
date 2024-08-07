import Architecture
import ComposableArchitecture
import Domain
import Foundation

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

    var query = "h"

    var songItemList: [MusicEntity.Search.Song.Item] = []
    var artistItemList: [MusicEntity.Search.Artist.Item] = []
    var albumItemList: [MusicEntity.Search.Album.Item] = []
    var topResultItemList: [MusicEntity.Search.TopResult.Item] = []
    var keywordItemList: [MusicEntity.Search.Keyword.Item] = []

    var fetchSearchSongItem: FetchState.Data<MusicEntity.Search.Song.Composite?> = .init(isLoading: false, value: .none)
    var fetchSearchArtistItem: FetchState.Data<MusicEntity.Search.Artist.Composite?> = .init(isLoading: false, value: .none)
    var fetchSearchAlbumItem: FetchState.Data<MusicEntity.Search.Album.Composite?> = .init(isLoading: false, value: .none)
    var fetchSearchTopResultItem: FetchState.Data<MusicEntity.Search.TopResult.Composite?> = .init(isLoading: false, value: .none)
    var fetchSearchKeywordItem: FetchState.Data<MusicEntity.Search.Keyword.Composite?> = .init(isLoading: false, value: .none)

  }

  enum Action: Equatable, BindableAction {
    case binding(BindingAction<State>)
    case teardown

    case searchSong(String)
    case searchArtist(String)
    case searchAlbum(String)
    case searchTopResult(String)

    case searchKeyword(String)

    case fetchSearchSongItem(Result<MusicEntity.Search.Song.Composite, CompositeErrorRepository>)
    case fetchSearchArtistItem(Result<MusicEntity.Search.Artist.Composite, CompositeErrorRepository>)
    case fetchSearchAlbumItem(Result<MusicEntity.Search.Album.Composite, CompositeErrorRepository>)
    case fetchSearchTopResultItem(Result<MusicEntity.Search.TopResult.Composite, CompositeErrorRepository>)
    case fetchSearchKeywordItem(Result<MusicEntity.Search.Keyword.Composite, CompositeErrorRepository>)

    case throwError(CompositeErrorRepository)
  }

  enum CancelID: String, CaseIterable {
    case teardown
    case requestSearchSong
    case requestSearchArtist
    case requestSearchAlbum
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
          .song(.init(query: query))
          .cancellable(pageID: pageID, id: CancelID.requestSearchSong, cancelInFlight: true)

      case .searchArtist(let query):
        guard !query.isEmpty else {
          return .none
        }

        state.fetchSearchArtistItem.isLoading = true

        return sideEffect
          .artist(.init(query: query))
          .cancellable(pageID: pageID, id: CancelID.requestSearchArtist, cancelInFlight: true)

      case .searchAlbum(let query):
        guard !query.isEmpty else { return .none }

        state.fetchSearchAlbumItem.isLoading = true

        return sideEffect
          .album(.init(query: query))
          .cancellable(pageID: pageID, id: CancelID.requestSearchAlbum, cancelInFlight: true)

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
            state.songItemList = state.songItemList + item.response.itemList
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
            state.artistItemList = state.artistItemList + item.response.itemList
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
            state.albumItemList = state.albumItemList + item.response.itemList
          }

          return .none

        case .failure(let error):
          return .run { await $0(.throwError(error)) }
        }

      case .fetchSearchTopResultItem(let result):
        state.fetchSearchTopResultItem.isLoading = true
        switch result {
        case .success(let item):
          if state.query == item.request.query {
            state.fetchSearchTopResultItem.value = item
            state.topResultItemList = state.topResultItemList + item.response.itemList
          }

          return .none

        case .failure(let error):
          return .run { await $0(.throwError(error)) }
        }

      case .fetchSearchKeywordItem(let result):
        state.fetchSearchKeywordItem.isLoading = true
        switch result {
        case .success(let item):
          if state.query == item.request.query {
            state.fetchSearchKeywordItem.value = item
            state.keywordItemList = state.keywordItemList + item.response.itemList
          }
          return .none

        case .failure(let error):
          return .run { await $0(.throwError(error)) }
        }

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
