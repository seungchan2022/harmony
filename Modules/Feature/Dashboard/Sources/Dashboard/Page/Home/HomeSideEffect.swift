import Architecture
import Combine
import CombineExt
import ComposableArchitecture
import Domain
import Foundation

// MARK: - HomeSideEffect

struct HomeSideEffect {
  let useCase: DashboardEnvironmentUsable
  let main: AnySchedulerOf<DispatchQueue>
  let navigator: RootNavigatorType

  init(
    useCase: DashboardEnvironmentUsable,
    main: AnySchedulerOf<DispatchQueue> = .main,
    navigator: RootNavigatorType)
  {
    self.useCase = useCase
    self.main = main
    self.navigator = navigator
  }
}

extension HomeSideEffect {
  var getMostPlayedSongItem: (MusicEntity.Chart.MostPlayedSong.Request) -> Effect<HomeReducer.Action> {
    { req in
      .publisher {
        useCase.musicUseCase
          .mostPlayedSong(req)
          .receive(on: main)
          .mapToResult()
          .map(HomeReducer.Action.fetchMostPlayedSongItem)
      }
    }
  }

  var getCityTopItem: (MusicEntity.Chart.CityTop.Request) -> Effect<HomeReducer.Action> {
    { req in
      .publisher {
        useCase.musicUseCase
          .cityTop(req)
          .receive(on: main)
          .mapToResult()
          .map(HomeReducer.Action.fetchCityTopItem)
      }
    }
  }

  var getDailyTopItem: (MusicEntity.Chart.DailyTop.Request) -> Effect<HomeReducer.Action> {
    { req in
      .publisher {
        useCase.musicUseCase
          .dailyTop(req)
          .receive(on: main)
          .mapToResult()
          .map(HomeReducer.Action.fetchDailyTopItem)
      }
    }
  }
}
