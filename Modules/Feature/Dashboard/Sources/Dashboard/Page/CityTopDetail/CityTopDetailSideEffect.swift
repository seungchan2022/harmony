import Architecture
import Combine
import ComposableArchitecture
import Domain
import Foundation

// MARK: - CityTopDetailSideEffect

struct CityTopDetailSideEffect {
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

extension CityTopDetailSideEffect {
  var getItem: (MusicEntity.Chart.CityTop.Item) -> Effect<CityTopDetailReducer.Action> {
    { item in
      .publisher {
        useCase.musicCityTopDetailUseCase
          .track(item.serialized())
          .receive(on: main)
          .mapToResult()
          .map(CityTopDetailReducer.Action.fetchItem)
      }
    }
  }
}

extension MusicEntity.Chart.CityTop.Item {
  fileprivate func serialized() -> MusicEntity.CityTopDetail.Track.Request {
    .init(id: id)
  }
}
