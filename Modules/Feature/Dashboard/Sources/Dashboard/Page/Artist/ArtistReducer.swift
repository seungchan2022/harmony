import Architecture
import ComposableArchitecture
import Domain
import Foundation

@Reducer
struct ArtistReducer {

  // MARK: Lifecycle

  init(
    pageID: String = UUID().uuidString,
    sideEffect: ArtistSideEffect)
  {
    self.pageID = pageID
    self.sideEffect = sideEffect
  }

  // MARK: Internal

  @ObservableState
  struct State: Equatable, Identifiable {

    // MARK: Lifecycle

    init(
      id: UUID = UUID(),
      item: MusicEntity.Search.TopResult.Item)
    {
      self.id = id
      self.item = item
    }

    // MARK: Internal

    let id: UUID
    let item: MusicEntity.Search.TopResult.Item

    var topSongItemList: [MusicEntity.Artist.TopSong.Item] = []
    var essentialAlbumItemList: [MusicEntity.Artist.EssentialAlbum.Item] = []
    var fulllAlbumItemList: [MusicEntity.Artist.FullAlbum.Item] = []
    var musicVideoItemList: [MusicEntity.Artist.MusicVideo.Item] = []
    var playItemList: [MusicEntity.Artist.PlayList.Item] = []
    var singleItemList: [MusicEntity.Artist.Single.Item] = []

    var fetchTopSongItem: FetchState.Data<MusicEntity.Artist.TopSong.Response?> = .init(isLoading: false, value: .none)
    var fetchEssentialAlbumItem: FetchState.Data<MusicEntity.Artist.EssentialAlbum.Response?> = .init(
      isLoading: false,
      value: .none)
    var fetchFullAlbumItem: FetchState.Data<MusicEntity.Artist.FullAlbum.Response?> = .init(isLoading: false, value: .none)
    var fetchMusicVideoItem: FetchState.Data<MusicEntity.Artist.MusicVideo.Response?> = .init(isLoading: false, value: .none)
    var fetchPlayItem: FetchState.Data<MusicEntity.Artist.PlayList.Response?> = .init(isLoading: false, value: .none)
    var fetchSingleItem: FetchState.Data<MusicEntity.Artist.Single.Response?> = .init(isLoading: false, value: .none)

  }

  enum Action: Equatable, BindableAction {
    case binding(BindingAction<State>)
    case teardown

    case getTopSongItem(MusicEntity.Search.TopResult.Item)
    case getEssentialAlbumItem(MusicEntity.Search.TopResult.Item)
    case getFullAlbumItem(MusicEntity.Search.TopResult.Item)
    case getMusicVideoItem(MusicEntity.Search.TopResult.Item)
    case getPlayItem(MusicEntity.Search.TopResult.Item)
    case getSingleItem(MusicEntity.Search.TopResult.Item)

    case fetchTopSongItem(Result<MusicEntity.Artist.TopSong.Response, CompositeErrorRepository>)
    case fetchEssentialAlbumItem(Result<MusicEntity.Artist.EssentialAlbum.Response, CompositeErrorRepository>)
    case fetchFullAlbumItem(Result<MusicEntity.Artist.FullAlbum.Response, CompositeErrorRepository>)
    case fetchMusicVideoItem(Result<MusicEntity.Artist.MusicVideo.Response, CompositeErrorRepository>)
    case fetchPlayItem(Result<MusicEntity.Artist.PlayList.Response, CompositeErrorRepository>)
    case fetchSingleItem(Result<MusicEntity.Artist.Single.Response, CompositeErrorRepository>)

    case throwError(CompositeErrorRepository)
  }

  enum CancelID: Equatable, CaseIterable {
    case teardown
    case requestTopSongItem
    case requestEssentialAlbumItem
    case requestFullAlbumItem
    case requestMusicVideoItem
    case requestPlayItem
    case requestSingleItem
  }

  var body: some Reducer<State, Action> {
    BindingReducer()
    Reduce { state, action in
      switch action {
      case .binding:
        return .none

      case .teardown:
        return .concatenate(
          CancelID.allCases.map { .cancel(pageID: pageID, id: $0) })

      case .getTopSongItem(let item):
        state.fetchTopSongItem.isLoading = true
        return sideEffect
          .getTopSongItem(item)
          .cancellable(pageID: pageID, id: CancelID.requestTopSongItem, cancelInFlight: true)

      case .getEssentialAlbumItem(let item):
        state.fetchEssentialAlbumItem.isLoading = true
        return sideEffect
          .getEssentialAlbumItem(item)
          .cancellable(pageID: pageID, id: CancelID.requestEssentialAlbumItem, cancelInFlight: true)

      case .getFullAlbumItem(let item):
        state.fetchFullAlbumItem.isLoading = true
        return sideEffect
          .getFullAlbumItem(item)
          .cancellable(pageID: pageID, id: CancelID.requestFullAlbumItem, cancelInFlight: true)

      case .getMusicVideoItem(let item):
        state.fetchMusicVideoItem.isLoading = true
        return sideEffect
          .getMusicVideoItem(item)
          .cancellable(pageID: pageID, id: CancelID.requestMusicVideoItem, cancelInFlight: true)

      case .getPlayItem(let item):
        state.fetchPlayItem.isLoading = true
        return sideEffect
          .getPlayItem(item)
          .cancellable(pageID: pageID, id: CancelID.requestPlayItem, cancelInFlight: true)

      case .getSingleItem(let item):
        state.fetchSingleItem.isLoading = true
        return sideEffect
          .getSingleItem(item)
          .cancellable(pageID: pageID, id: CancelID.requestSingleItem, cancelInFlight: true)

      case .fetchTopSongItem(let result):
        state.fetchTopSongItem.isLoading = false
        switch result {
        case .success(let item):
          state.fetchTopSongItem.value = item
          state.topSongItemList = state.topSongItemList + item.itemList
          return .none

        case .failure(let error):
          return .run { await $0(.throwError(error)) }
        }

      case .fetchEssentialAlbumItem(let result):
        state.fetchEssentialAlbumItem.isLoading = false
        switch result {
        case .success(let item):
          state.fetchEssentialAlbumItem.value = item
          state.essentialAlbumItemList = state.essentialAlbumItemList + item.itemList
          return .none

        case .failure(let error):
          return .run { await $0(.throwError(error)) }
        }

      case .fetchFullAlbumItem(let result):
        state.fetchFullAlbumItem.isLoading = false
        switch result {
        case .success(let item):
          state.fetchFullAlbumItem.value = item
          state.fulllAlbumItemList = state.fulllAlbumItemList + item.itemList
          return .none

        case .failure(let error):
          return .run { await $0(.throwError(error)) }
        }

      case .fetchMusicVideoItem(let result):
        state.fetchMusicVideoItem.isLoading = false
        switch result {
        case .success(let item):
          state.fetchMusicVideoItem.value = item
          state.musicVideoItemList = state.musicVideoItemList + item.itemList
          return .none

        case .failure(let error):
          return .run { await $0(.throwError(error)) }
        }

      case .fetchPlayItem(let result):
        state.fetchPlayItem.isLoading = false
        switch result {
        case .success(let item):
          state.fetchPlayItem.value = item
          state.playItemList = state.playItemList + item.itemList
          return .none

        case .failure(let error):
          return .run { await $0(.throwError(error)) }
        }

      case .fetchSingleItem(let result):
        state.fetchSingleItem.isLoading = false
        switch result {
        case .success(let item):
          state.fetchSingleItem.value = item
          state.singleItemList = state.singleItemList + item.itemList
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
  private let sideEffect: ArtistSideEffect

}
