import Architecture
import Combine
import ComposableArchitecture
import Domain
import Foundation

// MARK: - TopSongSideEffect

struct TopSongSideEffect {
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

extension TopSongSideEffect {
  var getItem: (MusicEntity.TopSong.Request) -> Effect<TopSongReducer.Action> {
    { req in
      .publisher {
        useCase.topSongUseCase
          .song(req)
          .receive(on: main)
          .mapToResult()
          .map(TopSongReducer.Action.fetchItem)
      }
    }
  }
}
