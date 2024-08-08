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

  var routeToDetail: (MusicEntity.Chart.CityTop.Item) -> Void {
    { item in
      navigator.next(
        linkItem: .init(
          path: Link.Dashboard.Path.cityTopDetail.rawValue,
          items: item),
        isAnimated: true)
    }
  }
}

//
// extension MusicEntity.Chart.CityTop.Item {
//  fileprivate func serialized() -> MusicEntity.CityTop.Seoul.Request {
//    .init(term: self.id)
//  }
// }
