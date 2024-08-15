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
    let id: UUID
    let item: MusicEntity.Search.TopResult.Item

    var topSongItemList: [MusicEntity.Artist.TopSong.Item] = []
    var essentialAlbumItemList: [MusicEntity.Artist.EssentialAlbum.Item] = []

    var fetchTopSongItem: FetchState.Data<MusicEntity.Artist.TopSong.Response?> = .init(isLoading: false, value: .none)
    var fetchEssentialAlbumItem: FetchState.Data<MusicEntity.Artist.EssentialAlbum.Response?> = .init(
      isLoading: false,
      value: .none)

    init(
      id: UUID = UUID(),
      item: MusicEntity.Search.TopResult.Item)
    {
      self.id = id
      self.item = item
    }
  }

  enum Action: Equatable, BindableAction {
    case binding(BindingAction<State>)
    case teardown

    case getTopSongItem(MusicEntity.Search.TopResult.Item)
    case getEssentialAlbumItem(MusicEntity.Search.TopResult.Item)

    case fetchTopSongItem(Result<MusicEntity.Artist.TopSong.Response, CompositeErrorRepository>)
    case fetchEssentialAlbumItem(Result<MusicEntity.Artist.EssentialAlbum.Response, CompositeErrorRepository>)

    case throwError(CompositeErrorRepository)
  }

  enum CancelID: Equatable, CaseIterable {
    case teardown
    case requestTopSongItem
    case requestEssentialAlbumItem
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
