import Architecture
import ComposableArchitecture
import Domain
import Foundation

@Reducer
struct MostPlayedSongReducer {

  // MARK: Lifecycle

  init(
    pageID: String = UUID().uuidString,
    sideEffect: MostPlayedSongSideEffect)
  {
    self.pageID = pageID
    self.sideEffect = sideEffect
  }

  // MARK: Internal

  @ObservableState
  struct State: Equatable, Identifiable {
    let id: UUID

    var itemList: [MusicEntity.Chart.MostPlayedSong.Item] = []

    var fetchItem: FetchState.Data<MusicEntity.Chart.MostPlayedSong.Response?> = .init(isLoading: false, value: .none)

    init(id: UUID = UUID()) {
      self.id = id
    }
  }

  enum Action: Equatable, BindableAction {
    case binding(BindingAction<State>)
    case teardown

    case getItem

    case fetchItem(Result<MusicEntity.Chart.MostPlayedSong.Response, CompositeErrorRepository>)

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

      case .getItem:
        state.fetchItem.isLoading = true
        return sideEffect
          .getItem(.init(limit: 200))
          .cancellable(pageID: pageID, id: CancelID.requestItem, cancelInFlight: true)

      case .fetchItem(let result):
        state.fetchItem.isLoading = false
        switch result {
        case .success(let item):
          state.fetchItem.value = item
          state.itemList = item.itemList
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
  private let sideEffect: MostPlayedSongSideEffect

}
