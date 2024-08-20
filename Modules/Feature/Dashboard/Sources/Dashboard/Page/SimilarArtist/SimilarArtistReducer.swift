import Architecture
import ComposableArchitecture
import Domain
import Foundation

// MARK: - SimilarArtistReducer

@Reducer
struct SimilarArtistReducer {

  // MARK: Lifecycle

  init(
    pageID: String = UUID().uuidString,
    sideEffect: SimilarArtistSideEffect)
  {
    self.pageID = pageID
    self.sideEffect = sideEffect
  }

  // MARK: Internal

  @ObservableState
  struct State: Equatable, Identifiable {
    let id: UUID

    let requestModel: MusicEntity.Artist.SimilarArtist.Request
    var itemList: [MusicEntity.Artist.SimilarArtist.Item] = []

    var fetchItem: FetchState.Data<MusicEntity.Artist.SimilarArtist.Response?> = .init(isLoading: false, value: .none)

    init(
      id: UUID = UUID(),
      requestModel: MusicEntity.Artist.SimilarArtist.Request)
    {
      self.id = id
      self.requestModel = requestModel
    }
  }

  enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
    case teardown

    case getItem(MusicEntity.Artist.SimilarArtist.Request)
    case fetchItem(Result<MusicEntity.Artist.SimilarArtist.Response, CompositeErrorRepository>)

    case routeToArtist(MusicEntity.Artist.SimilarArtist.Item)

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
          state.itemList = state.itemList.merge(item.itemList)
          return .none

        case .failure(let error):
          return .run { await $0(.throwError(error)) }
        }

      case .routeToArtist(let item):
        sideEffect.routeToArtist(item)
        return .none

      case .throwError(let error):
        sideEffect.useCase.toastViewModel.send(errorMessage: error.displayMessage)
        return .none
      }
    }
  }

  // MARK: Private

  private let pageID: String
  private let sideEffect: SimilarArtistSideEffect

}

extension [MusicEntity.Artist.SimilarArtist.Item] {
  fileprivate func merge(_ target: Self) -> Self {
    let new = target.reduce(self) { curr, next in
      guard !self.contains(where: { $0.id == next.id }) else { return curr }
      return curr + [next]
    }
    return new
  }
}
