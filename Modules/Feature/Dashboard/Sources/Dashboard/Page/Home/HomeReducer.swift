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

    // MARK: Lifecycle

    init(id: UUID = UUID()) {
      self.id = id
    }

    // MARK: Internal

    let id: UUID

    var mostPlayedSongItemList: [MusicEntity.Chart.MostPlayedSong.Item] = []
    var cityTopItemList: [MusicEntity.Chart.CityTop.Item] = []
    var dailyTopItemList: [MusicEntity.Chart.DailyTop.Item] = []
    var topPlayItemList: [MusicEntity.Chart.TopPlayList.Item] = []
    var topAlbumItemList: [MusicEntity.Chart.TopAlbum.Item] = []
    var topMusicVideoItemList: [MusicEntity.Chart.TopMusicVideo.Item] = []

    var fetchMostPlayedSongItem: FetchState.Data<MusicEntity.Chart.MostPlayedSong.Response?> = .init(
      isLoading: false,
      value: .none)
    var fetchCityTopItem: FetchState.Data<MusicEntity.Chart.CityTop.Response?> = .init(isLoading: false, value: .none)
    var fetchDailyTopItem: FetchState.Data<MusicEntity.Chart.DailyTop.Response?> = .init(isLoading: false, value: .none)
    var fetchTopPlayItem: FetchState.Data<MusicEntity.Chart.TopPlayList.Response?> = .init(isLoading: false, value: .none)
    var fetchTopAlbumItem: FetchState.Data<MusicEntity.Chart.TopAlbum.Response?> = .init(isLoading: false, value: .none)
    var fetchTopMusicVideoItem: FetchState.Data<MusicEntity.Chart.TopMusicVideo.Response?> = .init(isLoading: false, value: .none)

  }

  enum Action: Equatable, BindableAction {
    case binding(BindingAction<State>)
    case teardown

    case getMostPlayedSongItem
    case getCityTopItem
    case getDailyTopItem
    case getTopPlayItem
    case getTopAlbumItem
    case getTopMusicVideoItem

    case fetchMostPlayedSongItem(Result<MusicEntity.Chart.MostPlayedSong.Response, CompositeErrorRepository>)
    case fetchCityTopItem(Result<MusicEntity.Chart.CityTop.Response, CompositeErrorRepository>)
    case fetchDailyTopItem(Result<MusicEntity.Chart.DailyTop.Response, CompositeErrorRepository>)
    case fetchTopPlayItem(Result<MusicEntity.Chart.TopPlayList.Response, CompositeErrorRepository>)
    case fetchTopAlbumItem(Result<MusicEntity.Chart.TopAlbum.Response, CompositeErrorRepository>)
    case fetchTopMusicVideoItem(Result<MusicEntity.Chart.TopMusicVideo.Response, CompositeErrorRepository>)

    case routeToMostPlayedSong
    case routeToCityTop
    case routeToCityTopDeatil(MusicEntity.Chart.CityTop.Item)
    case routeToDailyTop
    case routeToTopPlayList
    case routeToTopAlbum
    case routeToTopMusicVideo

    case throwError(CompositeErrorRepository)
  }

  enum CancelID: Equatable, CaseIterable {
    case teardown
    case requestMostPlayedSongItem
    case requestCityTopItem
    case requestDailyTopItem
    case requestTopPlayItem
    case requestTopAlbumItem
    case requestTopMusicVideoItem
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
          .getMostPlayedSongItem(.init())
          .cancellable(pageID: pageID, id: CancelID.requestMostPlayedSongItem, cancelInFlight: true)

      case .getCityTopItem:
        state.fetchCityTopItem.isLoading = true
        return sideEffect
          .getCityTopItem(.init())
          .cancellable(pageID: pageID, id: CancelID.requestCityTopItem, cancelInFlight: true)

      case .getDailyTopItem:
        state.fetchDailyTopItem.isLoading = true
        return sideEffect
          .getDailyTopItem(.init())
          .cancellable(pageID: pageID, id: CancelID.requestDailyTopItem, cancelInFlight: true)

      case .getTopPlayItem:
        state.fetchTopPlayItem.isLoading = true
        return sideEffect
          .getTopPlayItem(.init())
          .cancellable(pageID: pageID, id: CancelID.requestTopPlayItem, cancelInFlight: true)

      case .getTopAlbumItem:
        state.fetchTopAlbumItem.isLoading = true
        return sideEffect
          .getTopAlbumItem(.init())
          .cancellable(pageID: pageID, id: CancelID.requestTopAlbumItem, cancelInFlight: true)

      case .getTopMusicVideoItem:
        state.fetchTopMusicVideoItem.isLoading = true
        return sideEffect
          .getTopMusicVideoItem(.init())
          .cancellable(pageID: pageID, id: CancelID.requestTopMusicVideoItem, cancelInFlight: true)

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

      case .fetchTopPlayItem(let result):
        state.fetchTopPlayItem.isLoading = false
        switch result {
        case .success(let item):
          state.fetchTopPlayItem.value = item
          state.topPlayItemList = item.itemList
          return .none

        case .failure(let error):
          return .run { await $0(.throwError(error)) }
        }

      case .fetchTopAlbumItem(let result):
        state.fetchTopAlbumItem.isLoading = false
        switch result {
        case .success(let item):
          state.fetchTopAlbumItem.value = item
          state.topAlbumItemList = item.itemList
          return .none

        case .failure(let error):
          return .run { await $0(.throwError(error)) }
        }

      case .fetchTopMusicVideoItem(let result):
        state.fetchTopMusicVideoItem.isLoading = false
        switch result {
        case .success(let item):
          state.fetchTopMusicVideoItem.value = item
          state.topMusicVideoItemList = item.itemList
          return .none

        case .failure(let error):
          return .run { await $0(.throwError(error)) }
        }

      case .routeToMostPlayedSong:
        sideEffect.routeToMostPlayedSong()
        return .none

      case .routeToCityTop:
        sideEffect.routeToCityTop()
        return .none

      case .routeToCityTopDeatil(let item):
        sideEffect.routeToCityTopDetail(item)
        return .none

      case .routeToDailyTop:
        sideEffect.routeToDailyTop()
        return .none

      case .routeToTopPlayList:
        sideEffect.routeToTopPlayList()
        return .none

      case .routeToTopAlbum:
        sideEffect.routeToTopAlbum()
        return .none

      case .routeToTopMusicVideo:
        sideEffect.routeToTopMusicVideo()
        return .none

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
