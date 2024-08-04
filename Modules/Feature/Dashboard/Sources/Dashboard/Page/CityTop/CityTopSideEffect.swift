import Architecture
import Combine
import ComposableArchitecture
import Domain
import Foundation

// MARK: - CityTopSideEffect

struct CityTopSideEffect {
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

extension CityTopSideEffect {
  var getItem: (MusicEntity.Chart.CityTop.Request) -> Effect<CityTopReducer.Action> {
    { req in
      .publisher {
        useCase.musicUseCase
          .cityTop(req)
          .receive(on: main)
          .mapToResult()
          .map(CityTopReducer.Action.fetchItem)
      }
    }
  }
}
