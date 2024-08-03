import Architecture
import ComposableArchitecture
import Domain
import Foundation

@Reducer
struct HomeReducer {

  // MARK: Lifecycle

  init(
    pageID: String = UUID().uuidString,
    sideEffect: HomeSideEffect)
  {
    self.pageID = pageID
    self.sideEffect = sideEffect
  }

  // MARK: Internal

  @ObservableState
  struct State: Equatable, Identifiable {
    let id: UUID

    var mostPlayedSongItemList: [MusicEntity.Chart.MostPlayedSong.Item] = []
    var cityTopItemList: [MusicEntity.Chart.CityTop.Item] = []
    var dailyTopItemList: [MusicEntity.Chart.DailyTop.Item] = []

    var fetchMostPlayedSongItem: FetchState.Data<MusicEntity.Chart.MostPlayedSong.Response?> = .init(
      isLoading: false,
      value: .none)
    var fetchCityTopItem: FetchState.Data<MusicEntity.Chart.CityTop.Response?> = .init(isLoading: false, value: .none)
    var fetchDailyTopItem: FetchState.Data<MusicEntity.Chart.DailyTop.Response?> = .init(isLoading: false, value: .none)

    init(id: UUID = UUID()) {
      self.id = id
    }
  }

  enum Action: Equatable, BindableAction {
    case binding(BindingAction<State>)
    case teardown

    case getMostPlayedSongItem
    case getCityTopItem
    case getDailyTopItem

    case fetchMostPlayedSongItem(Result<MusicEntity.Chart.MostPlayedSong.Response, CompositeErrorRepository>)
    case fetchCityTopItem(Result<MusicEntity.Chart.CityTop.Response, CompositeErrorRepository>)
    case fetchDailyTopItem(Result<MusicEntity.Chart.DailyTop.Response, CompositeErrorRepository>)

    case throwError(CompositeErrorRepository)
  }

  enum CancelID: Equatable, CaseIterable {
    case teardown
    case requestMostPlayedSongItem
    case requestCityTopItem
    case requestDailyTopItem
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

      case .getMostPlayedSongItem:
        state.fetchMostPlayedSongItem.isLoading = true
        return sideEffect
          .getMostPlayedSongItem(.init(limit: 20))
          .cancellable(pageID: pageID, id: CancelID.requestMostPlayedSongItem, cancelInFlight: true)

      case .getCityTopItem:
        state.fetchCityTopItem.isLoading = true
        return sideEffect
          .getCityTopItem(.init(limit: 20))
          .cancellable(pageID: pageID, id: CancelID.requestCityTopItem, cancelInFlight: true)

      case .getDailyTopItem:
        state.fetchDailyTopItem.isLoading = true
        return sideEffect
          .getDailyTopItem(.init(limit: 20))
          .cancellable(pageID: pageID, id: CancelID.requestDailyTopItem, cancelInFlight: true)

      case .fetchMostPlayedSongItem(let result):
        state.fetchMostPlayedSongItem.isLoading = false
        switch result {
        case .success(let item):
          state.fetchMostPlayedSongItem.value = item
          state.mostPlayedSongItemList = item.itemList
          return .none

        case .failure(let error):
          return .run { await $0(.throwError(error)) }
        }

      case .fetchCityTopItem(let result):
        state.fetchCityTopItem.isLoading = false
        switch result {
        case .success(let item):
          state.fetchCityTopItem.value = item
          state.cityTopItemList = item.itemList
          return .none

        case .failure(let error):
          return .run { await $0(.throwError(error)) }
        }

      case .fetchDailyTopItem(let result):
        state.fetchDailyTopItem.isLoading = false
        switch result {
        case .success(let item):
          state.fetchDailyTopItem.value = item
          state.dailyTopItemList = item.itemList
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
  private let sideEffect: HomeSideEffect

}
