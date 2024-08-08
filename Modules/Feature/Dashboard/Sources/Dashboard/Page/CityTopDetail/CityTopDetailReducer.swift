import Architecture
import ComposableArchitecture
import Domain
import Foundation

@Reducer
struct CityTopDetailReducer {

  // MARK: Lifecycle

  init(
    pageID: String = UUID().uuidString,
    sideEffect: CityTopDetailSideEffect)
  {
    self.pageID = pageID
    self.sideEffect = sideEffect
  }

  // MARK: Internal

  @ObservableState
  struct State: Equatable, Identifiable {
    let id: UUID

    ///    let item: MusicEntity.Chart.CityTop.Item = .init(id: "", name: "", curatorName: "", artwork: .init())
    let item: MusicEntity.Chart.CityTop.Item

    var itemList: [MusicEntity.CityTopDetail.Track.Item] = []

    var fetchItem: FetchState.Data<MusicEntity.CityTopDetail.Track.Response?> = .init(isLoading: false, value: .none)

    init(
      id: UUID = UUID(),
      item: MusicEntity.Chart.CityTop.Item)
    {
      self.id = id
      self.item = item
    }
  }

  enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
    case teardown

    case getItem(MusicEntity.Chart.CityTop.Item)
    case fetchItem(Result<MusicEntity.CityTopDetail.Track.Response, CompositeErrorRepository>)

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

      case .getItem(let item):
        state.fetchItem.isLoading = true
        return sideEffect
          .getItem(item)
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
  private let sideEffect: CityTopDetailSideEffect

}
