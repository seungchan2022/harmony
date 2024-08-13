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

  var getTopPlayItem: (MusicEntity.Chart.TopPlayList.Request) -> Effect<HomeReducer.Action> {
    { req in
      .publisher {
        useCase.musicUseCase
          .topPlayList(req)
          .receive(on: main)
          .mapToResult()
          .map(HomeReducer.Action.fetchTopPlayItem)
      }
    }
  }

  var getTopAlbumItem: (MusicEntity.Chart.TopAlbum.Request) -> Effect<HomeReducer.Action> {
    { req in
      .publisher {
        useCase.musicUseCase
          .topAlbum(req)
          .receive(on: main)
          .mapToResult()
          .map(HomeReducer.Action.fetchTopAlbumItem)
      }
    }
  }

  var getTopMusicVideoItem: (MusicEntity.Chart.TopMusicVideo.Request) -> Effect<HomeReducer.Action> {
    { req in
      .publisher {
        useCase.musicUseCase
          .topMusicVideo(req)
          .receive(on: main)
          .mapToResult()
          .map(HomeReducer.Action.fetchTopMusicVideoItem)
      }
    }
  }

  var routeToMostPlayedSong: () -> Void {
    {
      navigator
        .next(
          linkItem: .init(path: Link.Dashboard.Path.mostPlayedSong.rawValue),
          isAnimated: true)
    }
  }

  var routeToCityTop: () -> Void {
    {
      navigator
        .next(
          linkItem: .init(path: Link.Dashboard.Path.cityTop.rawValue),
          isAnimated: true)
    }
  }

  var routeToCityTopDetail: (MusicEntity.Chart.CityTop.Item) -> Void {
    { item in
      navigator.next(
        linkItem: .init(
          path: Link.Dashboard.Path.cityTopDetail.rawValue,
          items: item),
        isAnimated: true)
    }
  }

  var routeToDailyTop: () -> Void {
    {
      navigator
        .next(
          linkItem: .init(path: Link.Dashboard.Path.dailyTop.rawValue),
          isAnimated: true)
    }
  }

  var routeToDailyTopDetail: (MusicEntity.Chart.DailyTop.Item) -> Void {
    { item in
      navigator.next(
        linkItem: .init(
          path: Link.Dashboard.Path.dailyTopDetail.rawValue,
          items: item),
        isAnimated: true)
    }
  }

  var routeToTopPlayList: () -> Void {
    {
      navigator
        .next(
          linkItem: .init(path: Link.Dashboard.Path.topPlayList.rawValue),
          isAnimated: true)
    }
  }

  var routeToTopAlbum: () -> Void {
    {
      navigator
        .next(
          linkItem: .init(path: Link.Dashboard.Path.topAlbum.rawValue),
          isAnimated: true)
    }
  }

  var routeToTopMusicVideo: () -> Void {
    {
      navigator
        .next(
          linkItem: .init(path: Link.Dashboard.Path.topMusicVideo.rawValue),
          isAnimated: true)
    }
  }

}
