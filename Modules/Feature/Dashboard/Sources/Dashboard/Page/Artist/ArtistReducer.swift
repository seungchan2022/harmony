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
    var fetchTopSongItem: FetchState.Data<MusicEntity.Artist.TopSong.Response?> = .init(isLoading: false, value: .none)

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

    case getItem(MusicEntity.Search.TopResult.Item)

    case fetchTopSongItem(Result<MusicEntity.Artist.TopSong.Response, CompositeErrorRepository>)

    case throwError(CompositeErrorRepository)
  }

  enum CancelID: Equatable, CaseIterable {
    case teardown
    case requestItem
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

      case .getItem(let item):
        state.fetchTopSongItem.isLoading = true
        return sideEffect
          .getItem(item)
          .cancellable(pageID: pageID, id: CancelID.requestItem, cancelInFlight: true)

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
