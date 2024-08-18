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
      topSongRequestModel: MusicEntity.Artist.TopSong.Request,
      essentialAlbumRequestModel: MusicEntity.Artist.EssentialAlbum.Request,
      fullAlbumRequestModel: MusicEntity.Artist.FullAlbum.Request,
      musicVideoRequestModel: MusicEntity.Artist.MusicVideo.Request,
      playListRequestModel: MusicEntity.Artist.PlayList.Request,
      singRequestModel: MusicEntity.Artist.Single.Request,
      similarArtistRequestModel: MusicEntity.Artist.SimilarArtist.Request)
    {
      self.id = id
      self.topSongRequestModel = topSongRequestModel
      self.essentialAlbumRequestModel = essentialAlbumRequestModel
      self.fullAlbumRequestModel = fullAlbumRequestModel
      self.musicVideoRequestModel = musicVideoRequestModel
      self.playListRequestModel = playListRequestModel
      self.singRequestModel = singRequestModel
      self.similarArtistRequestModel = similarArtistRequestModel
    }

    // MARK: Internal

    let id: UUID

    let topSongRequestModel: MusicEntity.Artist.TopSong.Request
    let essentialAlbumRequestModel: MusicEntity.Artist.EssentialAlbum.Request
    let fullAlbumRequestModel: MusicEntity.Artist.FullAlbum.Request
    let musicVideoRequestModel: MusicEntity.Artist.MusicVideo.Request
    let playListRequestModel: MusicEntity.Artist.PlayList.Request
    let singRequestModel: MusicEntity.Artist.Single.Request
    let similarArtistRequestModel: MusicEntity.Artist.SimilarArtist.Request

    var topSongItemList: [MusicEntity.Artist.TopSong.Item] = []
    var essentialAlbumItemList: [MusicEntity.Artist.EssentialAlbum.Item] = []
    var fulllAlbumItemList: [MusicEntity.Artist.FullAlbum.Item] = []
    var musicVideoItemList: [MusicEntity.Artist.MusicVideo.Item] = []
    var playListItemList: [MusicEntity.Artist.PlayList.Item] = []
    var singleItemList: [MusicEntity.Artist.Single.Item] = []
    var similarArtistItemList: [MusicEntity.Artist.SimilarArtist.Item] = []

    var fetchTopSongItem: FetchState.Data<MusicEntity.Artist.TopSong.Response?> = .init(isLoading: false, value: .none)
    var fetchEssentialAlbumItem: FetchState.Data<MusicEntity.Artist.EssentialAlbum.Response?> = .init(
      isLoading: false,
      value: .none)
    var fetchFullAlbumItem: FetchState.Data<MusicEntity.Artist.FullAlbum.Response?> = .init(isLoading: false, value: .none)
    var fetchMusicVideoItem: FetchState.Data<MusicEntity.Artist.MusicVideo.Response?> = .init(isLoading: false, value: .none)
    var fetchPlayListItem: FetchState.Data<MusicEntity.Artist.PlayList.Response?> = .init(isLoading: false, value: .none)
    var fetchSingleItem: FetchState.Data<MusicEntity.Artist.Single.Response?> = .init(isLoading: false, value: .none)
    var fetchSimilarArtistItem: FetchState.Data<MusicEntity.Artist.SimilarArtist.Response?> = .init(
      isLoading: false,
      value: .none)

  }

  enum Action: Equatable, BindableAction {
    case binding(BindingAction<State>)
    case teardown

    case getTopSongItem(MusicEntity.Artist.TopSong.Request)
    case getEssentialAlbumItem(MusicEntity.Artist.EssentialAlbum.Request)
    case getFullAlbumItem(MusicEntity.Artist.FullAlbum.Request)
    case getMusicVideoItem(MusicEntity.Artist.MusicVideo.Request)
    case getPlayListItem(MusicEntity.Artist.PlayList.Request)
    case getSingleItem(MusicEntity.Artist.Single.Request)
    case getSimilarArtistItem(MusicEntity.Artist.SimilarArtist.Request)

    case fetchTopSongItem(Result<MusicEntity.Artist.TopSong.Response, CompositeErrorRepository>)
    case fetchEssentialAlbumItem(Result<MusicEntity.Artist.EssentialAlbum.Response, CompositeErrorRepository>)
    case fetchFullAlbumItem(Result<MusicEntity.Artist.FullAlbum.Response, CompositeErrorRepository>)
    case fetchMusicVideoItem(Result<MusicEntity.Artist.MusicVideo.Response, CompositeErrorRepository>)
    case fetchPlayListItem(Result<MusicEntity.Artist.PlayList.Response, CompositeErrorRepository>)
    case fetchSingleItem(Result<MusicEntity.Artist.Single.Response, CompositeErrorRepository>)
    case fetchSimilarArtistItem(Result<MusicEntity.Artist.SimilarArtist.Response, CompositeErrorRepository>)

    case throwError(CompositeErrorRepository)
  }

  enum CancelID: Equatable, CaseIterable {
    case teardown
    case requestTopSongItem
    case requestEssentialAlbumItem
    case requestFullAlbumItem
    case requestMusicVideoItem
    case requestPlayListItem
    case requestSingleItem
    case requestSimilarArtistItem
    case requestArtistItem
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

      case .getTopSongItem(let requestModel):
        state.fetchTopSongItem.isLoading = true
        return sideEffect
          .getTopSongItem(requestModel)
          .cancellable(pageID: pageID, id: CancelID.requestTopSongItem, cancelInFlight: true)

      case .getEssentialAlbumItem(let requestModel):
        state.fetchEssentialAlbumItem.isLoading = true
        return sideEffect
          .getEssentialAlbumItem(requestModel)
          .cancellable(pageID: pageID, id: CancelID.requestEssentialAlbumItem, cancelInFlight: true)

      case .getFullAlbumItem(let requestModel):
        state.fetchFullAlbumItem.isLoading = true
        return sideEffect
          .getFullAlbumItem(requestModel)
          .cancellable(pageID: pageID, id: CancelID.requestFullAlbumItem, cancelInFlight: true)

      case .getMusicVideoItem(let requestModel):
        state.fetchMusicVideoItem.isLoading = true
        return sideEffect
          .getMusicVideoItem(requestModel)
          .cancellable(pageID: pageID, id: CancelID.requestMusicVideoItem, cancelInFlight: true)

      case .getPlayListItem(let requestModel):
        state.fetchPlayListItem.isLoading = true
        return sideEffect
          .getPlayListItem(requestModel)
          .cancellable(pageID: pageID, id: CancelID.requestPlayListItem, cancelInFlight: true)

      case .getSingleItem(let requestModel):
        state.fetchSingleItem.isLoading = true
        return sideEffect
          .getSingleItem(requestModel)
          .cancellable(pageID: pageID, id: CancelID.requestSingleItem, cancelInFlight: true)

      case .getSimilarArtistItem(let requestModel):
        state.fetchSimilarArtistItem.isLoading = true
        return sideEffect
          .getSimilarArtistItem(requestModel)
          .cancellable(pageID: pageID, id: CancelID.requestSimilarArtistItem, cancelInFlight: true)

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

      case .fetchPlayListItem(let result):
        state.fetchPlayListItem.isLoading = false
        switch result {
        case .success(let item):
          state.fetchPlayListItem.value = item
          state.playListItemList = state.playListItemList + item.itemList
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

      case .fetchSimilarArtistItem(let result):
        state.fetchSimilarArtistItem.isLoading = false
        switch result {
        case .success(let item):
          state.fetchSimilarArtistItem.value = item
          state.similarArtistItemList = state.similarArtistItemList + item.itemList
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
