import Architecture
import ComposableArchitecture
import Domain
import Foundation

// MARK: - AlbumDetailReducer

@Reducer
struct AlbumDetailReducer {

  // MARK: Lifecycle

  init(
    pageID: String = UUID().uuidString,
    sideEffect: AlbumDetailSideEffect)
  {
    self.pageID = pageID
    self.sideEffect = sideEffect
  }

  // MARK: Internal

  @ObservableState
  struct State: Equatable, Identifiable {
    let id: UUID

    let item: MusicEntity.AlbumDetail.Track.Request

    var itemList: [MusicEntity.AlbumDetail.Track.Item] = []

    var fetchItem: FetchState.Data<MusicEntity.AlbumDetail.Track.Response?> = .init(isLoading: false, value: .none)

    init(id: UUID = UUID(), item: MusicEntity.AlbumDetail.Track.Request) {
      self.id = id
      self.item = item
    }
  }

  enum Action: Equatable, BindableAction {
    case binding(BindingAction<State>)
    case teardown

    case getItem

    case fetchItem(Result<MusicEntity.AlbumDetail.Track.Response, CompositeErrorRepository>)

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

      case .getItem:
        state.fetchItem.isLoading = true
        return sideEffect
          .getItem(state.item)
          .cancellable(pageID: pageID, id: CancelID.requestItem, cancelInFlight: true)

      case .fetchItem(let result):
        state.fetchItem.isLoading = false
        switch result {
        case .success(let item):
          state.fetchItem.value = item
          state.itemList = state.itemList.merge(item.itemList)
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
  private let sideEffect: AlbumDetailSideEffect

}

extension [MusicEntity.AlbumDetail.Track.Item] {
  fileprivate func merge(_ target: Self) -> Self {
    let new = target.reduce(self) { curr, next in
      guard !self.contains(where: { $0.id == next.id }) else { return curr }
      return curr + [next]
    }
    return new
  }
}
