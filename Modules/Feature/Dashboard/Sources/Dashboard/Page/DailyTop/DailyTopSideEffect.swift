import Architecture
import Combine
import ComposableArchitecture
import Domain
import Foundation

// MARK: - DailyTopSideEffect

struct DailyTopSideEffect {
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

extension DailyTopSideEffect {
  var getItem: (MusicEntity.Chart.DailyTop.Request) -> Effect<DailyTopReducer.Action> {
    { req in
      .publisher {
        useCase.musicUseCase
          .dailyTop(req)
          .receive(on: main)
          .mapToResult()
          .map(DailyTopReducer.Action.fetchItem)
      }
    }
  }
}
