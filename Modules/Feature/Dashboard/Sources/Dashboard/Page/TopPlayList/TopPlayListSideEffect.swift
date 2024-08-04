import Architecture
import Combine
import ComposableArchitecture
import Domain
import Foundation

// MARK: - TopPlayListSideEffect

struct TopPlayListSideEffect {
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

extension TopPlayListSideEffect {
  var getItem: (MusicEntity.Chart.TopPlayList.Request) -> Effect<TopPlayListReducer.Action> {
    { req in
      .publisher {
        useCase.musicUseCase
          .topPlayList(req)
          .receive(on: main)
          .mapToResult()
          .map(TopPlayListReducer.Action.fetchItem)
      }
    }
  }
}
