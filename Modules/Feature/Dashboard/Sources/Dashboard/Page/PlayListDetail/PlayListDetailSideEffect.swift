import Architecture
import Combine
import ComposableArchitecture
import Domain
import Foundation

// MARK: - PlayListDetailSideEffect

struct PlayListDetailSideEffect {
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

extension PlayListDetailSideEffect {
  var getItem: (MusicEntity.PlayListDetail.Track.Request) -> Effect<PlayListDetailReducer.Action> {
    { req in
      .publisher {
        useCase.playListDetailUseCase
          .track(req)
          .receive(on: main)
          .mapToResult()
          .map(PlayListDetailReducer.Action.fetchItem)
      }
    }
  }
}
