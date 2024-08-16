import Architecture
import Combine
import ComposableArchitecture
import Domain
import Foundation

// MARK: - TopAlbumSideEffect

struct TopAlbumSideEffect {
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

extension TopAlbumSideEffect {
  var getItem: (MusicEntity.Chart.TopAlbum.Request) -> Effect<TopAlbumReducer.Action> {
    { req in
      .publisher {
        useCase.musicUseCase
          .topAlbum(req)
          .receive(on: main)
          .mapToResult()
          .map(TopAlbumReducer.Action.fetchItem)
      }
    }
  }

  var routeToDetail: (MusicEntity.Chart.TopAlbum.Item) -> Void {
    { item in
      navigator.next(
        linkItem: .init(
          path: Link.Dashboard.Path.albumDetail.rawValue,
          items: item),
        isAnimated: true)
    }
  }
}
