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
  var getItem: (MusicEntity.Chart.Request) -> Effect<HomeReducer.Action> {
    { req in
      .publisher {
        useCase.musicUseCase
          .chart(req)
          .receive(on: main)
          .mapToResult()
          .map(HomeReducer.Action.fetchItem)
      }
    }
  }
}
