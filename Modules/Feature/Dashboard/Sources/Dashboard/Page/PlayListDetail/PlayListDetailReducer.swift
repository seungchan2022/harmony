import Architecture
import ComposableArchitecture
import Domain
import Foundation

@Reducer
struct PlayListDetailReducer {

  // MARK: Lifecycle

  init(
    pageID: String = UUID().uuidString,
    sideEffect: PlayListDetailSideEffect)
  {
    self.pageID = pageID
    self.sideEffect = sideEffect
  }

  // MARK: Internal

  @ObservableState
  struct State: Equatable, Identifiable {
    let id: UUID

    let requestModel: MusicEntity.PlayListDetail.Track.Request

    var itemList: [MusicEntity.PlayListDetail.Track.Item] = []

    var fetchItem: FetchState.Data<MusicEntity.PlayListDetail.Track.Response?> = .init(isLoading: false, value: .none)

    init(
      id: UUID = UUID(),
      requestModel: MusicEntity.PlayListDetail.Track.Request)
    {
      self.id = id
      self.requestModel = requestModel
    }
  }

  enum Action: Equatable, BindableAction {
    case binding(BindingAction<State>)
    case teardown

    case getItem(MusicEntity.PlayListDetail.Track.Request)

    case fetchItem(Result<MusicEntity.PlayListDetail.Track.Response, CompositeErrorRepository>)

    case throwError(CompositeErrorRepository)
  }

  enum CancelID: String, CaseIterable {
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
  private let sideEffect: PlayListDetailSideEffect

}
