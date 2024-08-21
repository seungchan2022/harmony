import Architecture
import ComposableArchitecture
import Domain
import Foundation

// MARK: - FullAlbumReducer

@Reducer
struct FullAlbumReducer {

  // MARK: Lifecycle

  init(
    pageID: String = UUID().uuidString,
    sideEffect: FullAlbumSideEffect)
  {
    self.pageID = pageID
    self.sideEffect = sideEffect
  }

  // MARK: Internal

  @ObservableState
  struct State: Equatable, Identifiable {
    let id: UUID

    let requestModel: MusicEntity.Album.FullAlbum.Request

    var itemList: [MusicEntity.Album.FullAlbum.Item] = []

    var fetchItem: FetchState.Data<MusicEntity.Album.FullAlbum.Response?> = .init(isLoading: false, value: .none)

    init(
      id: UUID = UUID(),
      requestModel: MusicEntity.Album.FullAlbum.Request)
    {
      self.id = id
      self.requestModel = requestModel
    }
  }

  enum Action: Equatable, BindableAction {
    case binding(BindingAction<State>)
    case teardown

    case getItem(MusicEntity.Album.FullAlbum.Request)
    case fetchItem(Result<MusicEntity.Album.FullAlbum.Response, CompositeErrorRepository>)

    case routeToDetail(MusicEntity.Album.FullAlbum.Item)

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

      case .getItem(let requestModel):
        state.fetchItem.isLoading = true
        return sideEffect
          .getItem(requestModel)
          .cancellable(pageID: pageID, id: CancelID.requestItem, cancelInFlight: true)

      case .fetchItem(let result):
        state.fetchItem.isLoading = false
        switch result {
        case .success(let item):
          state.fetchItem.value = item
          state.itemList = state.itemList + item.itemList
          return .none

        case .failure(let error):
          sideEffect.useCase.toastViewModel.send(errorMessage: error.displayMessage)
          return .none
        }

      case .routeToDetail(let item):
        sideEffect.routeToDetail(item)
        return .none

      case .throwError(let error):
        return .run { await $0(.throwError(error)) }
      }
    }
  }

  // MARK: Private

  private let pageID: String
  private let sideEffect: FullAlbumSideEffect

}
